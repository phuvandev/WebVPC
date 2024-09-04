import { Component, ElementRef, ViewChild } from '@angular/core';
import { NhaCungCap } from 'src/app/models/supplier.model';
import { SupplierService } from 'src/app/services/supplier.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-supplier',
  templateUrl: './manage-supplier.component.html',
  styleUrls: ['./manage-supplier.component.css']
})
export class ManageSupplierComponent {
  ListSupplier: NhaCungCap[] = [];

  p: number = 1;
  pageSize: number = 10;
  totalItems: number = 0;

  //Tìm kiếm
  search: string = '';

  MaNCC: any;
  TenNCC: string = '';
  DiaChi: string = '';
  SDT: string = '';
  TrangThai = '1';
  
  @ViewChild('scroll') scroll!: ElementRef;
  
  //Mở/đóng modal khi chưa selectedRow
  openModal: boolean = false;
  @ViewChild('modalCreate') modalCreate!: ElementRef;
  @ViewChild('modalUpdate') modalUpdate!: ElementRef;

  constructor(private supplierService:SupplierService) { }
  ngOnInit(){
    this.getListSupplier(this.p);
  }

  getListSupplier(p: number) {
    const obj = {
      page: p,
      pageSize: this.pageSize,
      tenNCC: this.search
    }
    this.supplierService.getAllAdmin(obj).subscribe(res => {
      this.ListSupplier = res.data;
      this.totalItems = res.totalItems;
      this.p = p;
      setTimeout(() => {
        if (this.scroll && this.scroll.nativeElement) {
          this.scroll.nativeElement.scrollIntoView({ behavior: 'smooth' });
        }
      }, 0);
    });
  }

  // Xử lý khi ấn vào dòng
  selectedRow: NhaCungCap | null = null;
  onRowClick(nhacungcap: NhaCungCap) {
    this.selectedRow = nhacungcap;
    this.MaNCC = this.selectedRow.maNCC;
    this.TenNCC = this.selectedRow.tenNCC;
    this.DiaChi = this.selectedRow.diaChi;
    this.SDT = this.selectedRow.sdt;
    this.TrangThai = this.selectedRow.trangThai.toString();
  }

  //mở form tạo mới
  showCreate(){
    this.TenNCC = '';
    this.DiaChi = '';
    this.SDT = '';
    this.TrangThai = '1';
    this.selectedRow = null;
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

  //thoát
  cancel() {
    this.selectedRow = null;
  }

  //Thêm
  create() {
    if (!this.TenNCC || !this.DiaChi || !this.SDT || !this.TrangThai) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin (*)',
        icon: 'warning'
      });
      return;
    }
    // Kiểm tra số điện thoại
    const phoneRegex = /(84|0[3|5|7|8|9])+([0-9]{8})\b/;
    if (!phoneRegex.test(this.SDT)) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Số điện thoại không hợp lệ, vui lòng nhập lại!',
        icon: 'warning'
      });
      return;
    }

    const NhaCungCap: any = {
      tenNCC: this.TenNCC,
      diaChi: this.DiaChi,
      sdt: this.SDT,
      trangThai: this.TrangThai
    }
  
    this.supplierService.create(NhaCungCap).subscribe(res => {
      Swal.fire({
        title: 'Thành công',
        text: 'Tạo nhà cung cấp thành công!',
        icon: 'success'
      }).then(() => {
        this.getListSupplier(this.p); //refresh

        // Đóng modal khi tạo thành công
        const modalCreate = this.modalCreate.nativeElement;
        modalCreate.classList.remove('show');
        modalCreate.style.display = 'none';
        document.body.classList.remove('modal-open');
        const modalBackdrop = document.getElementsByClassName('modal-backdrop');
        for (let i = 0; i < modalBackdrop.length; i++) {
          modalBackdrop[i].remove();
        }
      });
    });
  }

  //Sửa
  update() {
    if (this.selectedRow) {
      if (!this.TenNCC || !this.DiaChi || !this.SDT) {
        Swal.fire({
          title: 'Thông báo',
          text: 'Vui lòng nhập đầy đủ thông tin (*)',
          icon: 'warning'
        });
        return;
      }
      // Kiểm tra số điện thoại
      const phoneRegex = /(84|0[3|5|7|8|9])+([0-9]{8})\b/;
      if (!phoneRegex.test(this.SDT)) {
        Swal.fire({
          title: 'Thông báo',
          text: 'Số điện thoại không hợp lệ, vui lòng nhập lại!',
          icon: 'warning'
        });
        return;
      }

      const NhaCungCap: any = {
        maNCC: this.MaNCC,
        tenNCC: this.TenNCC,
        diaChi: this.DiaChi,
        sdt: this.SDT,
        trangThai: this.TrangThai
      }
      
      // Gọi phương thức sửa từ service
      this.supplierService.update(NhaCungCap).subscribe(res => {
        Swal.fire({
          title: 'Thành công',
          text: 'Cập nhật nhà cung cấp thành công!',
          icon: 'success'
        }).then(() => {
          this.selectedRow = null;
          this.getListSupplier(this.p);
          
          // Đóng modal khi sửa thành công
          const modalUpdate = this.modalUpdate.nativeElement;
          modalUpdate.classList.remove('show');
          modalUpdate.style.display = 'none';
          document.body.classList.remove('modal-open');
          const modalBackdrop = document.getElementsByClassName('modal-backdrop');
          for (let i = 0; i < modalBackdrop.length; i++) {
            modalBackdrop[i].remove();
          }
        });
      });
    }
  }
  //Xóa
  delete() {
    if (this.selectedRow) {
      const id = this.selectedRow.maNCC;
      Swal.fire({
        title: 'Thông báo',
        text: 'Bạn có chắc chắn muốn xóa thông tin nhà cung cấp này?',
        icon: 'warning',
        showCancelButton: true,
        cancelButtonText: 'Hủy'
      }).then((result) => {
        if (result.isConfirmed) {
          this.supplierService.delete(id).subscribe(res => {
            Swal.fire({
              title: 'Thông báo',
              text: 'Xóa nhà cung cấp thành công!',
              icon: 'success'
            }).then(() => {
              this.selectedRow = null;
              this.getListSupplier(this.p);
            });
          }, error => {
            Swal.fire({
              icon: 'error',
              title: 'Lỗi',
              text: "Không thể xoá nhà cung cấp này!"
            }).then(() => {
              this.selectedRow = null;
              this.getListSupplier(this.p);
            });
          });
        } 
        else if (result.dismiss === Swal.DismissReason.cancel) {
          this.selectedRow = null;
          this.getListSupplier(this.p);
        }
      });
    }
  }
}
