import { Component } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { ActivatedRoute, Router } from '@angular/router';
import { OwlOptions } from 'ngx-owl-carousel-o';
import { DongSanPham } from 'src/app/models/category.model';
import { SanPham } from 'src/app/models/product.model';
import { CartService } from 'src/app/services/cart.service';
import { CategoryService } from 'src/app/services/category.service';
import { ProductService } from 'src/app/services/product.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css']
})
export class ProductComponent {
  DataProduct: SanPham = {
    maSP: 0,
    tenSP: '',
    anhDaiDien: '',
    soLuong: 0,
    kichThuoc: '',
    trongLuong: '',
    matKinh: '',
    chatLieuDay: '',
    chongNuoc: '',
    loaiMay: '',
    moTa: '',
    ngayTao: '',
    trangThai: 0,
    maDSP: 0,

    tenDSP: '',
    giaBan: 0,
    phanTramGiamGia: 0,
    giaSauGiam: 0
  }
  MaDSP: number = 0;
  ListSameCategory: SanPham[] = [];
  ListCategory: DongSanPham[] = [];

  quantity = 1;

  constructor(private productService:ProductService, private route:ActivatedRoute, private title:Title, private categoryService:CategoryService, private cartService: CartService, private router:Router) { }
  ngOnInit(){
    this.getOne();
    this.getSameCategory();
    this.getListCategory();
  }

  // Hàm ngăn không cho nhập liệu trực tiếp từ bàn phím
  preventInput(event: KeyboardEvent) {
    event.preventDefault(); // Ngăn chặn hành động mặc định của sự kiện
  }

  //Thêm vào giỏ hàng
  addToCart(res: any, quantity: number) {
    if (quantity <= 5) {
      this.cartService.addToCart(res.maSP, quantity);
    } 
    else {
      Swal.fire({
        icon: 'warning',
        title: 'Thông báo',
        text: 'Số lượng sản phẩm đặt mua không được vượt quá 5 sản phẩm!',
      });
    }
  }

  getOne() {
    this.route.params.subscribe(params => {
      const id = +params['id'];
      this.productService.getOne(id).subscribe(res => {

        if(res.success) {
          this.DataProduct = res.data;
          this.MaDSP = res.data.maDSP;
          // Đặt tiêu đề của trang
          const pageTitle = `Đồng hồ ${this.DataProduct?.tenSP} - Văn Phú Casio`;
          this.title.setTitle(pageTitle);
          this.getSameCategory();
        } 
        else {
          Swal.fire({
            icon: 'error',
            title: 'Lỗi',
            text: res.message,
            timer: 2000
          }).then(() => {
            this.router.navigate(['/']);
          });
        }  
      });
    });
  }
  getSameCategory() {
    this.route.params.subscribe(params => {
      const id = +params['id'];
      this.productService.getSameCategory(this.MaDSP, id).subscribe(res => {
        this.ListSameCategory = res.data;
      });
    });
  }
  getListCategory() {
    this.categoryService.getAllClient().subscribe(res => {
      this.ListCategory = res.data;
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
