import { Component, ElementRef, ViewChild } from '@angular/core';
import { Quyen } from 'src/app/models/role.model';
import { RoleService } from 'src/app/services/role.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-role',
  templateUrl: './manage-role.component.html',
  styleUrls: ['./manage-role.component.css']
})
export class ManageRoleComponent {
  ListRole: Quyen[] = [];

  p: number = 1;
  pageSize: number = 10;
  totalItems: number = 0;

  //Tìm kiếm
  search: string = '';

  MaQuyen: any;
  TenQuyen: string = '';
  TrangThai: string = '';
  
  //Mở/đóng modal khi chưa selectedRow
  openModal: boolean = false;
  // @ViewChild('modalCreate') modalCreate!: ElementRef;
  @ViewChild('modalUpdate') modalUpdate!: ElementRef;

  constructor(private roleService:RoleService) { }
  ngOnInit(){
    this.getListRole();
  }

  getListRole() {
    this.roleService.getAllAdmin().subscribe(res => {
      this.ListRole = res.data;
    });
  }

  // Xử lý khi ấn vào dòng
  selectedRow: Quyen | null = null;
  onRowClick(quyen: Quyen) {
    this.selectedRow = quyen;
    this.MaQuyen = this.selectedRow.maQuyen;
    this.TenQuyen = this.selectedRow.tenQuyen;
    this.TrangThai = this.selectedRow.trangThai.toString();
  }

  // //mở form tạo mới
  // showCreate(){
  //   this.TenQuyen = '';
  //   this.TrangThai = '1';
  //   this.selectedRow = null;
  // }

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

  // //mở form xóa
  // showDelete() {
  //   if (!this.selectedRow) {
  //     Swal.fire({
  //       title: 'Thông báo',
  //       text: 'Vui lòng chọn một dòng để xóa!',
  //       icon: 'warning'
  //     });
  //     this.openModal = false;
  //   }
  //   else {
  //     this.openModal = true;
  //   }
  // }

  //thoát
  cancel() {
    this.selectedRow = null;
  }

  // //Thêm
  // create() {
  //   if (!this.TenQuyen || !this.TrangThai) {
  //     Swal.fire({
  //       title: 'Thông báo',
  //       text: 'Vui lòng nhập đầy đủ thông tin (*)',
  //       icon: 'warning'
  //     });
  //     return;
  //   }

  //   const Quyen: any = {
  //     tenQuyen: this.TenQuyen,
  //     trangThai: this.TrangThai
  //   }
  
  //   this.roleService.create(Quyen).subscribe(res => {
  //     Swal.fire({
  //       title: 'Thành công',
  //       text: 'Tạo mới quyền thành công!',
  //       icon: 'success'
  //     }).then(() => {
  //         this.getListRole(); //refresh

  //         // Đóng modal khi tạo thành công
  //         const modalCreate = this.modalCreate.nativeElement;
  //         modalCreate.classList.remove('show');
  //         modalCreate.style.display = 'none';
  //         document.body.classList.remove('modal-open');
  //         const modalBackdrop = document.getElementsByClassName('modal-backdrop');
  //         for (let i = 0; i < modalBackdrop.length; i++) {
  //           modalBackdrop[i].remove();
  //         }
  //     });
  //   });
  // }
  
  //Sửa
  update() {
    if (this.selectedRow) {
      if (!this.TenQuyen) {
        Swal.fire({
          title: 'Thông báo',
          text: 'Vui lòng nhập đầy đủ thông tin (*)',
          icon: 'warning'
        });
        return;
      }

      const Quyen: any = {
        maQuyen: this.MaQuyen,
        tenQuyen: this.TenQuyen,
        trangThai: this.TrangThai
      }

      Swal.fire({
        title: 'Thông báo',
        text: 'Bạn có chắc chắn muốn sửa quyền này?',
        icon: 'warning',
        showCancelButton: true,
        cancelButtonText: 'Hủy'
      }).then((result) => {
        if (result.isConfirmed) {
          // Gọi phương thức sửa từ service
          this.roleService.update(Quyen).subscribe(res => {
            Swal.fire({
              title: 'Thành công',
              text: 'Cập nhật quyền thành công!',
              icon: 'success'
            }).then(() => {
              this.selectedRow = null;
              this.getListRole();
              
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
      });
    }
  }
  
  // //Xóa
  // delete() {
  //   if (this.selectedRow) {
  //     const id = this.selectedRow.maQuyen;
  //     Swal.fire({
  //       title: 'Thông báo',
  //       text: 'Bạn có chắc chắn muốn xóa quyền này?',
  //       icon: 'warning',
  //       showCancelButton: true,
  //       cancelButtonText: 'Hủy'
  //     }).then((result) => {
  //       if (result.isConfirmed) {
  //         this.roleService.delete(id).subscribe(res => {
  //           Swal.fire({
  //             title: 'Thông báo',
  //             text: 'Xóa quyền thành công!',
  //             icon: 'success'
  //           }).then(() => {
  //             this.selectedRow = null;
  //             this.getListRole();
  //           });
  //         });
  //       } 
  //       else if (result.dismiss === Swal.DismissReason.cancel) {
  //         this.selectedRow = null;
  //         this.getListRole();
  //       }
  //     });
  //   }
  // }
}
