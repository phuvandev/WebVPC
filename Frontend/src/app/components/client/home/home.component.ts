import { Component, OnInit } from '@angular/core';
import { OwlOptions } from 'ngx-owl-carousel-o';
import { Banner } from 'src/app/models/banner.model';
import { DongSanPham } from 'src/app/models/category.model';
import { SanPham } from 'src/app/models/product.model';
import { Slide } from 'src/app/models/slide.model';
import { BannerService } from 'src/app/services/banner.service';
import { CategoryService } from 'src/app/services/category.service';
import { ProductService } from 'src/app/services/product.service';
import { SlideService } from 'src/app/services/slide.service';
import { CartService } from 'src/app/services/cart.service';
import { SettingService } from 'src/app/services/setting.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit{
  ListSlide: Slide[] = [];
  ListBanner: Banner[] = [];
  ListNew: SanPham[] = [];
  ListHot: SanPham[] = [];
  ListSale: SanPham[] = [];
  ListCategory: DongSanPham[] = [];
  SoLuong: number = 10;

  NameWebsite: string = '';
  AddressWebsite: string = '';
  EmailWebsite: string = '';
  PhoneWebsite: string = '';
  WorkingTime: string = '';

  constructor(private slideService:SlideService, private bannerService:BannerService, private productService:ProductService, private categoryService:CategoryService, private cartService:CartService, private settingService:SettingService) { }
  ngOnInit(){
    this.getListSlide();
    this.getListBanner();
    this.getListNew();
    this.getListHot();
    this.getListSale();
    this.getListCategory();
    this.getDataWebsite();
  }

  //Observable: xử lý các yêu cầu HTTP
  //subscribe được gọi để đăng ký và xử lý dữ liệu Observable phát ra: 3 tham số next, error, complete
  getListSlide() {
    this.slideService.getAllClient().subscribe(res => {
      this.ListSlide = res.data;
    });
  }
  getListBanner() {
    this.bannerService.getAllClient().subscribe(res => {
      this.ListBanner = res.data;
    });
  }
  getListNew() {
    this.productService.getNew(this.SoLuong).subscribe(res => {
      this.ListNew = res.data;
    });
  }
  getListHot() {
    this.productService.getHot(this.SoLuong).subscribe(res => {
      this.ListHot = res.data;
    });
  }
  getListSale() {
    this.productService.getSale(this.SoLuong).subscribe(res => {
      this.ListSale = res.data;
    });
  }
  getListCategory() {
    this.categoryService.getAllClient().subscribe(res => {
      this.ListCategory = res.data;
    });
  }
  //Thêm vào giỏ hàng
  addToCart(id: number) {
    this.cartService.addToCart(id, 1);
  }

  getDataWebsite() {
    this.settingService.getBySign('EMAIL').subscribe(res => { 
      this.EmailWebsite = res.data.moTa;
    });
    this.settingService.getBySign('PHONE').subscribe(res => { 
      this.PhoneWebsite = res.data.moTa;
    });
    this.settingService.getBySign('WORKING_TIME').subscribe(res => { 
      this.WorkingTime = res.data.moTa;
    });
  }

  productOptions: OwlOptions = {
    loop: true,
    nav: false,
    margin: 8,
    autoplay: true,
    autoplayHoverPause: true,
    autoplayTimeout: 5000,
    dots: false,
    responsive: {
      0: {
        items: 2
      },
      600: {
        items: 3
      },
      1000: {
        items: 4
      }
    }
  };
  
  categoryOptions: OwlOptions = {
    loop: true,
    nav: false,
    margin: 8,
    autoplay: true,
    autoplayHoverPause: true,
    autoplayTimeout: 5000,
    dots: false,
    responsive: {
      0: {
        items: 2
      },
      600: {
        items: 4
      },
      1000: {
        items: 5
      }
    }
  };
} 
