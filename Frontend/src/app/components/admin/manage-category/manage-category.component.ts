import { Component, ElementRef, ViewChild } from '@angular/core';
import { DongSanPham } from 'src/app/models/category.model';
import { CategoryService } from 'src/app/services/category.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-category',
  templateUrl: './manage-category.component.html',
  styleUrls: ['./manage-category.component.css']
})
export class ManageCategoryComponent {
  ListCategory: DongSanPham[] = [];
  MaDSP:any;
  TenDSP: string = '';
  Logo: any;
  TrangThai = '1';

  p: number = 1;
  pageSize: number = 6;
  totalItems: number = 0;

  //Tìm kiếm
  search: string = '';

  previewImageUrl: string | ArrayBuffer | null = null;

  @ViewChild('scroll') scroll!: ElementRef;

  //Mở/đóng modal khi chưa selectedRow
  openModal: boolean = false;
  @ViewChild('modalCreate') modalCreate!: ElementRef;
  @ViewChild('modalUpdate') modalUpdate!: ElementRef;
  @ViewChild('fileInputC') fileInputC!: ElementRef; 
  @ViewChild('fileInputU') fileInputU!: ElementRef; 

  constructor(private categoryService:CategoryService) { }
  ngOnInit(){
    this.getListCategory(this.p);
  }

  getListCategory(p: number) {
    const obj = {
      page: p,
      pageSize: this.pageSize,
      tenDSP: this.search
    }
    this.categoryService.getAllAdmin(obj).subscribe(res => {
      this.ListCategory = res.data;
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
  selectedRow: DongSanPham | null = null;
  onRowClick(dongsanpham: DongSanPham) {
    this.selectedRow = dongsanpham;
    this.MaDSP = this.selectedRow.maDSP;
    this.TenDSP = this.selectedRow.tenDSP;
    this.Logo = this.selectedRow.logo;
    this.TrangThai = this.selectedRow.trangThai.toString();
  }

  //mở form tạo mới
  showCreate(){
    this.TenDSP = '';
    this.Logo = '';
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
    this.previewImageUrl = null;
    // Đặt lại giá trị của input file
    if (this.fileInputC || this.fileInputU) {
      this.fileInputC.nativeElement.value = '';
      this.fileInputU.nativeElement.value = '';
    }
  }

  // Xử lý khi người dùng chọn một tệp ảnh
  onFileChange(event: any) {
    const fileList: FileList = event.target.files;// Lấy danh sách các tệp được chọn từ sự kiện change
    if (fileList.length > 0) {
      this.Logo = fileList[0];
      const reader = new FileReader(); // Tạo một đối tượng FileReader để đọc dữ liệu của tệp
      reader.onload = () => {
        // Gán URL dữ liệu của ảnh vào biến previewImageUrl
        this.previewImageUrl = reader.result;
      };
      // Đọc tệp ảnh dưới dạng URL dữ liệu (data URL)
      reader.readAsDataURL(this.Logo);
    }
  }

  //Thêm
  create() {
    if (!this.TenDSP || !this.Logo || !this.TrangThai) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin (*)',
        icon: 'warning'
      });
      return;
    }

    const formData = new FormData();
    formData.append('tenDSP', this.TenDSP)
    formData.append('File', this.Logo!);
    formData.append('trangThai', this.TrangThai);
  
    this.categoryService.create(formData).subscribe(res => {
      Swal.fire({
        title: 'Thành công',
        text: 'Tạo dòng sản phẩm thành công!',
        icon: 'success'
      }).then(() => {
          this.getListCategory(this.p); //refresh

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
      if (!this.TenDSP) {
        Swal.fire({
          title: 'Thông báo',
          text: 'Vui lòng nhập đầy đủ thông tin (*)',
          icon: 'warning'
        });
        return;
      }
      const formData = new FormData();
      formData.append('maDSP', this.MaDSP);
      formData.append('tenDSP', this.TenDSP);
      formData.append('File', this.Logo!);
      formData.append('trangThai', this.TrangThai);
      
      // Gọi phương thức sửa từ service
      this.categoryService.update(formData).subscribe(res => {
        Swal.fire({
          title: 'Thành công',
          text: 'Cập nhật dòng sản phẩm thành công!',
          icon: 'success'
        }).then(() => {
          this.selectedRow = null;
          this.getListCategory(this.p);
          
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
      const id = this.selectedRow.maDSP;
      Swal.fire({
        title: 'Thông báo',
        text: 'Bạn có chắc chắn muốn xóa dòng sản phẩm này?',
        icon: 'warning',
        showCancelButton: true,
        cancelButtonText: 'Hủy'
      }).then((result) => {
        if (result.isConfirmed) {
          this.categoryService.delete(id).subscribe(res => {
            Swal.fire({
              title: 'Thông báo',
              text: 'Xóa dòng sản phẩm thành công!',
              icon: 'success'
            }).then(() => {
              this.selectedRow = null;
              this.getListCategory(this.p);
            });
          }, error => {
            Swal.fire({
              icon: 'error',
              title: 'Lỗi',
              text: "Không thể xoá dòng sản phẩm này!"
            }).then(() => {
              this.selectedRow = null;
              this.getListCategory(this.p);
            });
          });
        } 
        else if (result.dismiss === Swal.DismissReason.cancel) {
          this.selectedRow = null;
          this.getListCategory(this.p);
        }
      });
    }
  }
}
