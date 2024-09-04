import { Component, ElementRef, ViewChild } from '@angular/core';
import { Menu } from 'src/app/models/menu.model';
import { MenuService } from 'src/app/services/menu.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-menu',
  templateUrl: './manage-menu.component.html',
  styleUrls: ['./manage-menu.component.css']
})
export class ManageMenuComponent {
  ListMenu: Menu[] = [];

  MaMenu: any;
  TenMenu: string = '';
  Link: string = '';
  TrangThai = '1';

  //Tìm kiếm
  search: string = '';

  //Mở/đóng modal khi chưa selectedRow
  openModal: boolean = false;
  @ViewChild('modalUpdate') modalUpdate!: ElementRef;

  constructor(private menuService:MenuService) { }

  ngOnInit(){
    this.getListMenu();
  }

  getListMenu() {
    this.menuService.getAllAdmin().subscribe(res => {
      this.ListMenu = res.data;
    });
  }

  // Xử lý khi ấn vào dòng
  selectedRow: Menu | null = null;
  onRowClick(menu: Menu) {
    this.selectedRow = menu;
    this.MaMenu = this.selectedRow.maMenu;
    this.TenMenu = this.selectedRow.tenMenu;
    this.Link = this.selectedRow.link;
    this.TrangThai = this.selectedRow.trangThai.toString();
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
  //thoát
  cancel() {
    this.selectedRow = null;
  }
  
  //Sửa
  update() {
    if (this.selectedRow) {
      if (!this.TenMenu || !this.Link) {
        Swal.fire({
          title: 'Thông báo',
          text: 'Vui lòng nhập đầy đủ thông tin (*)',
          icon: 'warning'
        });
        return;
      }
      
      // Tạo một đối tượng từ dữ liệu được chọn
      const Menu: any = {
        maMenu: this.MaMenu,
        tenMenu: this.TenMenu,
        link: this.Link,
        trangThai: this.TrangThai
      }

      Swal.fire({
        title: 'Thông báo',
        text: 'Bạn có chắc chắn muốn sửa menu này?',
        icon: 'warning',
        showCancelButton: true,
        cancelButtonText: 'Hủy'
      }).then((result) => {
        if (result.isConfirmed) {
          // Gọi phương thức sửa từ service
          this.menuService.update(Menu).subscribe(res => {
            Swal.fire({
              title: 'Thành công',
              text: 'Cập nhật menu thành công!',
              icon: 'success'
            }).then(() => {
                this.selectedRow = null;
                this.getListMenu(); //refresh

                // Đóng modal khi tạo thành công
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
}
