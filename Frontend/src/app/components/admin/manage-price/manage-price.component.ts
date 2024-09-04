import { Component, ElementRef, ViewChild } from '@angular/core';
import { GiaSanPham } from 'src/app/models/price.model';
import { SanPham } from 'src/app/models/product.model';
import { PriceService } from 'src/app/services/price.service';
import { ProductService } from 'src/app/services/product.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-price',
  templateUrl: './manage-price.component.html',
  styleUrls: ['./manage-price.component.css']
})
export class ManagePriceComponent {
  ListPrice: GiaSanPham[] = [];
  ListProduct: SanPham[] = [];
  ListProductSearch: SanPham[] = [];

  p: number = 1;
  pageSize: number = 10;
  totalItems: number = 0;

  MaGSP:any;
  GiaBan: number = 0;
  PhanTramGiamGia: number = 0;
  NgayBD: string = '';
  NgayKT: string = '';
  MaSP:any;
      
  TenSP: string = '';
  AnhDaiDien: string = '';
  GiaSauGiam: number = 0;

  //Tìm kiếm
  search: string = '';
  search2: string = '';

  @ViewChild('scroll') scroll!: ElementRef;

  //Mở/đóng modal khi chưa selectedRow
  openModal: boolean = false;
  @ViewChild('modalCreate') modalCreate!: ElementRef;
  @ViewChild('modalUpdate') modalUpdate!: ElementRef;

  constructor(private priceService:PriceService, private productService:ProductService) { }

  ngOnInit(){
    this.getListPrice(this.p);
    this.getListProduct(this.p);
    this.getListProductSearch();
  }

  getListPrice(p: number) {
    const obj = {
      page: p,
      pageSize: this.pageSize,
      tenSP: this.search
    }
    this.priceService.getAllAdmin(obj).subscribe(res => {
      this.ListPrice = res.data;
      this.totalItems = res.totalItems;
      this.p = p;
      setTimeout(() => {
        if (this.scroll && this.scroll.nativeElement) {
          this.scroll.nativeElement.scrollIntoView({ behavior: 'smooth' });
        }
      }, 0);
    });
  }

  getListProduct(p: number) {
    const obj = {
      page: p,
      pageSize: this.pageSize,
      tenSP: this.search
    }
    this.productService.getAllAdmin(obj).subscribe(res => {
      this.ListProduct = res.data;
    });
  }

  getListProductSearch() {
    const obj = {
      page: 1,
      pageSize: 20,
      tenSP: this.search2
    }
    this.productService.getWithoutPrice(obj).subscribe(res => {
      this.ListProductSearch = res.data;
    });
  }

  //format ngay/thang/nam
  formatDate(date: string): string {
    const originalDate = new Date(date);
    originalDate.setDate(originalDate.getDate() + 1);
    const formattedDate = originalDate.toISOString().slice(0, 10);
    return formattedDate;
  }

  // Xử lý khi ấn vào dòng
  selectedRow: GiaSanPham | null = null;
  onRowClick(giasanpham: GiaSanPham) {
    this.selectedRow = giasanpham;

    this.MaGSP = this.selectedRow.maGSP;
    this.GiaBan = this.selectedRow.giaBan;
    this.PhanTramGiamGia = this.selectedRow.phanTramGiamGia;
    this.NgayBD = this.formatDate(this.selectedRow.ngayBD);
    this.NgayKT = this.formatDate(this.selectedRow.ngayKT);
    this.MaSP = this.selectedRow.maSP;
    this.TenSP = this.selectedRow.tenSP;
    this.AnhDaiDien = this.selectedRow.anhDaiDien;
    this.GiaSauGiam = this.selectedRow.giaSauGiam;
  }

  //mở form tạo mới
  showCreate(){
    this.selectedRow = null;

    this.GiaBan = 0;
    this.PhanTramGiamGia = 0;
    this.NgayBD = '';
    this.NgayKT = '';
    this.MaSP = null;
    this.search2 = '';
  }
  //mở form sửa
  showUpdate() {
    if (!this.selectedRow) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng chọn một dòng để sửa!',
        icon: 'warning'
      });
      this.openModal = false;
    }
    else {
      this.openModal = true;
    }
  }
  //mở form xóa
  showDelete() {
    if (!this.selectedRow) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng chọn một dòng để xóa!',
        icon: 'warning'
      });
      this.openModal = false;
    }
    else {
      this.openModal = true;
    }
  }
  
  // Hàm được gọi khi có sự thay đổi trong trường tìm kiếm
  onSearchChange(event: any) {
    this.search2 = event.target.value;
    this.getListProductSearch(); 
  }
  
  //làm mới
  refresh() {
    this.GiaBan = 0;
    this.PhanTramGiamGia = 0;
    this.NgayBD = '';
    this.NgayKT = '';
    this.MaSP = null;
    this.TenSP = '';
  }
  //thoát
  cancel() {
    this.search2 = '';
    this.selectedRow = null;
  }

  //Thêm
  create() {
    if (isNaN(this.GiaBan) || isNaN(this.PhanTramGiamGia)) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập số!',
        icon: 'warning'
      });
      return; // Dừng hàm nếu có lỗi
    }
    if (!this.GiaBan || !this.MaSP) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin (*)',
        icon: 'warning'
      });
      return;
    }

    const GiaSanPham: any = {
      GiaBan: this.GiaBan,
      PhanTramGiamGia: this.PhanTramGiamGia,
      NgayBD: this.NgayBD === '' ? null : this.NgayBD,
      NgayKT: this.NgayKT === '' ? null : this.NgayKT,
      MaSP: this.MaSP
    }
  
    this.priceService.create(GiaSanPham).subscribe(res => {
      Swal.fire({
        title: 'Thành công',
        text: 'Tạo giá sản phẩm thành công!',
        icon: 'success'
      }).then(() => {
        // Đóng modal khi tạo thành công
        const modalCreate = this.modalCreate.nativeElement;
        modalCreate.classList.remove('show');
        modalCreate.style.display = 'none';
        document.body.classList.remove('modal-open');
        const modalBackdrop = document.getElementsByClassName('modal-backdrop');
        for (let i = 0; i < modalBackdrop.length; i++) {
          modalBackdrop[i].remove();
        }

        this.getListProductSearch();
        this.getListPrice(this.p); //refresh
      });
    });
  }

  //Sửa
  update() {
    if (this.selectedRow) {
      if (!this.GiaBan || !this.MaSP) {
        Swal.fire({
          title: 'Thông báo',
          text: 'Vui lòng nhập đầy đủ thông tin (*)',
          icon: 'warning'
        });
        return;
      }
      
      const GiaSanPham: any = {
        MaGSP: this.MaGSP,
        GiaBan: this.GiaBan,
        PhanTramGiamGia: this.PhanTramGiamGia,
        NgayBD: this.NgayBD === '' ? null : this.NgayBD,
        NgayKT: this.NgayKT === '' ? null : this.NgayKT,
        MaSP: this.MaSP
      }
      
      // Gọi phương thức sửa từ service
      this.priceService.update(GiaSanPham).subscribe(res => {
        Swal.fire({
          title: 'Thành công',
          text: 'Cập nhật giá sản phẩm thành công!',
          icon: 'success'
        }).then(() => {
          // Đóng modal khi sửa thành công
          const modalUpdate = this.modalUpdate.nativeElement;
          modalUpdate.classList.remove('show');
          modalUpdate.style.display = 'none';
          document.body.classList.remove('modal-open');
          const modalBackdrop = document.getElementsByClassName('modal-backdrop');
          for (let i = 0; i < modalBackdrop.length; i++) {
            modalBackdrop[i].remove();
          }

          this.selectedRow = null;
          this.getListPrice(this.p);
        });
      });
    }
  }
  //Xóa
  delete() {
    if (this.selectedRow) {
      const id = this.selectedRow.maGSP;
      Swal.fire({
        title: 'Thông báo',
        text: 'Bạn có chắc chắn muốn xóa thông tin giá sản phẩm này?',
        icon: 'warning',
        showCancelButton: true,
        cancelButtonText: 'Hủy'
      }).then((result) => {
        if (result.isConfirmed) {
          this.priceService.delete(id).subscribe(res => {
            Swal.fire({
              title: 'Thông báo',
              text: 'Xóa sản phẩm thành công!',
              icon: 'success',
            }).then(() => {
              this.selectedRow = null;
              this.getListPrice(this.p);
            });
          });
        } 
        else if (result.dismiss === Swal.DismissReason.cancel) {
          this.selectedRow = null;
          this.getListPrice(this.p);
        }
      });
    }
  }
}
