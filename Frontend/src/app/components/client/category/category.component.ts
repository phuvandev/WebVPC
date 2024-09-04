import { Component, ElementRef, OnChanges, SimpleChanges, ViewChild } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { ActivatedRoute, Router } from '@angular/router';
import { DongSanPham } from 'src/app/models/category.model';
import { SanPham } from 'src/app/models/product.model';
import { CartService } from 'src/app/services/cart.service';
import { CategoryService } from 'src/app/services/category.service';
import { ProductService } from 'src/app/services/product.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-category',
  templateUrl: './category.component.html',
  styleUrls: ['./category.component.css']
})
export class CategoryComponent {
  DataCategory: DongSanPham = {
    maDSP: 0,
    tenDSP: '',
    logo: '',
    trangThai: 0
  };
  ListProduct: SanPham[] = [];
  p: number = 1;
  pageSize: number = 12;
  totalItems: number = 0;

  @ViewChild('scroll') scroll!: ElementRef;

  change: any = "1";

  selectedChongNuoc: string = "";
  minGia: number | null = null;
  maxGia: number | null = null;

  selectedPriceRange: string = "";
  selectedWaterResistance: string = "";

  constructor(private categoryService: CategoryService, private productService: ProductService, private route: ActivatedRoute, private title: Title, private cartService: CartService, private router:Router) { }

  ngOnInit() {
    // Subscribe để theo dõi thay đổi trong route parameters
    this.route.params.subscribe(params => {
      // Đặt trang hiện tại về 1 khi có sự thay đổi trong route parameters
      this.p = 1;
      this.getOne();
      this.getListProduct(this.p);
      this.resetFilters(); // Gọi hàm resetFilters để đặt lại giá trị của các bộ lọc
    });
  }

  resetFilters() {
    this.selectedPriceRange = ""; // Đặt lại bộ lọc giá
    this.selectedWaterResistance = ""; // Đặt lại bộ lọc chống nước
    this.minGia = null; // Đặt lại giá trị minGia
    this.maxGia = null; // Đặt lại giá trị maxGia
    this.selectedChongNuoc = ""; // Đặt lại giá trị chống nước
  }

  ngOnChanges(changes: SimpleChanges) {
    // Kiểm tra xem có sự thay đổi trong các input properties của component hay không, trong trường hợp này là route
    if (changes['route'] && !changes['route'].isFirstChange()) {
      // Đặt trang hiện tại về 1 khi có sự thay đổi trong route parameters
      this.p = 1;
      this.getOne();
      this.getListProduct(this.p);
    }
  }

  

  // Thêm vào giỏ hàng
  addToCart(id: number) {
    this.cartService.addToCart(id, 1);
  }

  getOne() {
    this.route.params.subscribe(params => {
      const id = +params['id'];
      this.categoryService.getOne(id).subscribe(res => {
        if(res.success) {
          this.DataCategory = res.data;
          // Đặt tiêu đề của trang
          const pageTitle = `Dòng sản phẩm ${this.DataCategory?.tenDSP} - Văn Phú Casio`;
          this.title.setTitle(pageTitle);
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

  getListProduct(p: number) {
    this.p = p; // Cập nhật this.p với giá trị trang mới
    this.route.params.subscribe(params => {
      const id = +params['id'];
      const obj = {
        maDSP: id,
        page: this.p,
        pageSize: this.pageSize,
        kieuSX: this.change,
        minGia: this.minGia,
        maxGia: this.maxGia,
        chongNuoc: this.selectedChongNuoc
      };
      this.productService.getByCategory(obj).subscribe((res) => {
        this.ListProduct = res.data;
        this.totalItems = res.totalItems;
        setTimeout(() => {
          if (this.scroll && this.scroll.nativeElement) {
            this.scroll.nativeElement.scrollIntoView({ behavior: 'smooth' });
          }
        }, 0);
      });
    });
  }

  // Hàm xử lý sự kiện khi click vào khoảng giá
  filterByPrice(minGia: number | null, maxGia: number | null, rangeLabel: string) {
    if (this.selectedPriceRange === rangeLabel) {
      // Nếu khoảng giá đã được chọn trước đó, bỏ chọn
      this.minGia = null;
      this.maxGia = null;
      this.selectedPriceRange = "";
    } else {
      // Nếu khoảng giá chưa được chọn, chọn khoảng giá mới
      this.minGia = minGia;
      this.maxGia = maxGia;
      this.selectedPriceRange = rangeLabel; // Đặt giá trị của dòng giá đã chọn
    }
    this.p = 1; // Đặt lại về trang đầu tiên khi chọn bộ lọc mới
    this.getListProduct(this.p);
  }

  // Hàm xử lý sự kiện khi chọn chống nước
  filterByChongNuoc(chongNuoc: string, label: string) {
    if (this.selectedWaterResistance === label) {
      // Nếu chống nước đã được chọn trước đó, bỏ chọn
      this.selectedChongNuoc = "";
      this.selectedWaterResistance = "";
    } else {
      // Nếu chống nước chưa được chọn, chọn chống nước mới
      this.selectedChongNuoc = chongNuoc;
      this.selectedWaterResistance = label; // Đặt giá trị của dòng chống nước đã chọn
    }
    this.p = 1; // Reset lại trang hiện tại về 1
    this.getListProduct(this.p); // Gọi lại hàm lấy danh sách sản phẩm với bộ lọc mới
  }

  // Hàm xử lý sự kiện khi lựa chọn từ dropdown
  onSelectFilter(event: Event) {
    this.resetFilters();

    this.p = 1; // Đặt lại về trang đầu tiên khi chọn bộ lọc mới
    this.route.params.subscribe(params => {
      const id = +params['id'];
      const obj = {
        page: this.p,
        pageSize: this.pageSize,
        maDSP: id,
        kieuSX: this.change
      };
      this.productService.getByCategory(obj).subscribe((res) => {
        this.ListProduct = res.data;
        this.totalItems = res.totalItems;
      });
    });
  }
}
