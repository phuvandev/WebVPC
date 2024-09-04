import { Component, ElementRef, ViewChild } from '@angular/core';
import { NguoiDung } from 'src/app/models/user.model';
import { AuthenticateService } from 'src/app/services/authenticate.service';
import { UserService } from 'src/app/services/user.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-customer',
  templateUrl: './manage-customer.component.html',
  styleUrls: ['./manage-customer.component.css']
})
export class ManageCustomerComponent {
  ListCustomer: NguoiDung[] = [];
  MaND:any;
  TaiKhoan: string = '';
  MatKhau: string = '';
  XacNhanMatKhau: string = '';
  Email: string = '';
  HoTen: string = '';
  NgaySinh: string = '';
  GioiTinh: string = '';
  AnhDaiDien: any;
  DiaChi: string = '';
  SDT: string = '';
  NgayThamGia: string = '';
  TrangThai: string = '';
  MaQuyen: any;
  TenQuyen: string = '';

  p: number = 1;
  pageSize: number = 10;
  totalItems: number = 0;

  //Tìm kiếm
  search: string = '';

  user:any;

  @ViewChild('scroll') scroll!: ElementRef;

  //Mở/đóng modal khi chưa selectedRow
  openModal: boolean = false;
  @ViewChild('modalDetail') modalDetail!: ElementRef;

  constructor(private customerService:UserService, private authenticateService:AuthenticateService) { }
  ngOnInit(){
    this.user = this.authenticateService.checkLogin();

    this.getListCustomer(this.p);
  }

  getListCustomer(p: number) {
    const obj = {
      page: p,
      pageSize: this.pageSize,
      hoTen: this.search
    }
    this.customerService.getAllCustomer(obj).subscribe(res => {
      this.ListCustomer = res.data;
      this.totalItems = res.totalItems;
      this.p = p;
      setTimeout(() => {
        if (this.scroll && this.scroll.nativeElement) {
          this.scroll.nativeElement.scrollIntoView({ behavior: 'smooth' });
        }
      }, 0);
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
  selectedRow: NguoiDung | null = null;
  onRowClick(customer: NguoiDung) {
    this.selectedRow = customer;
    this.MaND = this.selectedRow.maND;
    this.TaiKhoan = this.selectedRow.taiKhoan;
    this.Email = this.selectedRow.email;
    this.HoTen = this.selectedRow.hoTen;
    this.NgaySinh = this.formatDate(this.selectedRow.ngaySinh);
    this.GioiTinh = this.selectedRow.gioiTinh;
    this.AnhDaiDien = this.selectedRow.anhDaiDien;
    this.DiaChi = this.selectedRow.diaChi;
    this.SDT = this.selectedRow.sdt;
    this.NgayThamGia = this.selectedRow.ngayThamGia;
    this.TrangThai = this.selectedRow.trangThai.toString();
    this.MaQuyen = this.selectedRow.maQuyen;
    this.TenQuyen = this.selectedRow.tenQuyen;
  }
  
  showDetail() {
    if (!this.selectedRow) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng chọn khách hàng để xem chi tiết!',
        icon: 'warning'
      });
      this.openModal = false;
    }
    else {
      this.openModal = true;
    }
  }

  //thoát
  cancel() {
    this.selectedRow = null;
  }

  lock() {
    Swal.fire({
      title: 'Xác nhận mật khẩu quản trị viên để tiếp tục',
      input: 'password',
      inputPlaceholder: 'Nhập mật khẩu quản trị viên',
      showCancelButton: true,
      confirmButtonText: 'Xác nhận',
      cancelButtonText: 'Hủy',
      preConfirm: (password) => {
        if (!password) {
          Swal.showValidationMessage('Vui lòng nhập mật khẩu!');
          return;
        }

        const check: any = {
          TaiKhoan: this.user.taiKhoan,
          MatKhau: password
        };
        this.authenticateService.login(check).subscribe(res => {
          if (res.status === 404) {
            Swal.fire({
              icon: 'error',
              title: 'Lỗi',
              text: 'Mật khẩu chưa chính xác, vui lòng xác nhận lại!'
            });
          }
          else {
            const formData = new FormData();
            formData.append('maND', this.MaND);
            formData.append('trangThai', '0');

            this.customerService.update(formData).subscribe(res => {
              Swal.fire({
                title: 'Thành công',
                text: 'Đã khóa khách hàng!',
                icon: 'success'
              }).then(() => {
                this.selectedRow = null;
                this.getListCustomer(this.p); //refresh
              });
            });
          }
        });
      }
    }).then((result) => {
      if (result.dismiss === Swal.DismissReason.cancel) {
        this.selectedRow = null;
        this.getListCustomer(this.p);
      }
    });
  }

  unlock() {
    Swal.fire({
      title: 'Xác nhận mật khẩu quản trị viên để tiếp tục',
      input: 'password',
      inputPlaceholder: 'Nhập mật khẩu quản trị viên',
      showCancelButton: true,
      confirmButtonText: 'Xác nhận',
      cancelButtonText: 'Hủy',
      preConfirm: (password) => {
        if (!password) {
          Swal.showValidationMessage('Vui lòng nhập mật khẩu!');
          return;
        }

        const check: any = {
          TaiKhoan: this.user.taiKhoan,
          MatKhau: password
        };
        this.authenticateService.login(check).subscribe(res => {
          if (res.status === 404) {
            Swal.fire({
              icon: 'error',
              title: 'Lỗi',
              text: 'Mật khẩu chưa chính xác, vui lòng xác nhận lại!'
            });
          }
          else {
            const formData = new FormData();
            formData.append('maND', this.MaND);
            formData.append('trangThai', '1');

            this.customerService.update(formData).subscribe(res => {
              Swal.fire({
                title: 'Thành công',
                text: 'Đã mở khóa khách hàng!',
                icon: 'success'
              }).then(() => {
                this.selectedRow = null;
                this.getListCustomer(this.p); //refresh
              });
            });
          }
        });
      }
    }).then((result) => {
      if (result.dismiss === Swal.DismissReason.cancel) {
        this.selectedRow = null;
        this.getListCustomer(this.p);
      }
    });
  }
}
