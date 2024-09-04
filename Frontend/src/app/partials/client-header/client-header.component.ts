import { Component, ElementRef, OnInit, Renderer2 } from '@angular/core';
import { DongSanPham } from 'src/app/models/category.model';
import { Menu } from 'src/app/models/menu.model';
import { CategoryService } from 'src/app/services/category.service';
import { MenuService } from 'src/app/services/menu.service';
import { CartService } from 'src/app/services/cart.service';
import { AuthenticateService } from 'src/app/services/authenticate.service';
import { SettingService } from 'src/app/services/setting.service';
import { NavigationEnd, Router } from '@angular/router';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-client-header',
  templateUrl: './client-header.component.html',
  styleUrls: ['./client-header.component.css']
})
export class ClientHeaderComponent implements OnInit{
  ListCategory: DongSanPham[] = [];
  ListMenu: Menu[] = [];
  count: number = 0;
  //xử lý đóng mở category
  isNavbarOpen = false;
  user: any;

  NameWebsite: string = '';
  LogoWebsite: string = '';
  PhoneWebsite: string = '';

  key: string = '';

  isHomePage: boolean = true;
  subscription: Subscription;

  constructor(private categoryService:CategoryService, private menuService:MenuService, private renderer:Renderer2, private el: ElementRef, private cartService: CartService, private authenticateService: AuthenticateService, private settingService:SettingService, private router:Router) {
    this.closeNavbarIfOpen();
    // Subscribe to router events
    this.subscription = this.router.events.subscribe(event => {
      if (event instanceof NavigationEnd) {
        this.isHomePage = event.url === '/';
        this.user = this.authenticateService.checkLogin();
      }
    });
  }
  
  ngOnInit(){
    this.getListCategory();
    this.getListMenu();
    this.cartService.cartUpdated.subscribe(() => {
      this.loadCart();
    });
    this.loadCart();

    this.user = this.authenticateService.checkLogin();

    this.getDataWebsite();
  }

  //Load giỏ hàng
  loadCart() {
    var cart = this.cartService.loadCart();
    this.count = cart.Count;
  }

  //Renderer2: thêm, sửa, xóa các phần tử, thuộc tính và các sự kiện trong DOM.
  //ElementRef: lấy ra phần tử từ DOM
  toggleNavbar() {
    this.isNavbarOpen = !this.isNavbarOpen;
    const navbar = this.el.nativeElement.querySelector('.categories_menu_inner');
    if (navbar) {
      if (this.isNavbarOpen) {
        this.renderer.setStyle(navbar, 'display', 'block');
      } else {
        this.renderer.setStyle(navbar, 'display', 'none');
      }
    }
  }
  closeNavbarIfOpen() {
    if (this.isNavbarOpen) {
      this.toggleNavbar();
    }
  }
  
  taiKhoan() {
    location.assign('/tai-khoan')
  }

  getListCategory() {
    this.categoryService.getAllClient().subscribe(res => {
      this.ListCategory = res.data;
    });
  }
  getListMenu() {
    this.menuService.getAllClient().subscribe(res => {
      this.ListMenu = res.data;
    });
  }

  getDataWebsite() {
    this.settingService.getBySign('NAME_WEB').subscribe(res => { 
      this.NameWebsite = res.data.moTa;
    });
    this.settingService.getBySign('LOGO').subscribe(res => { 
      this.LogoWebsite = res.data.anh;
    });
    this.settingService.getBySign('PHONE').subscribe(res => { 
      this.PhoneWebsite = res.data.moTa;
    });
  }

  search() {
    this.router.navigate(['/tim-kiem'], { queryParams: { 'name': this.key } }).then(() => {
      this.key = '';
    });
  }
}
