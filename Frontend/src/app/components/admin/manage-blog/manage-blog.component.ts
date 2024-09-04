import { Component, ElementRef, ViewChild } from '@angular/core';
import { AngularEditorConfig } from '@kolkov/angular-editor';
import { TinTuc } from 'src/app/models/blog.model';
import { AuthenticateService } from 'src/app/services/authenticate.service';
import { BlogService } from 'src/app/services/blog.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-blog',
  templateUrl: './manage-blog.component.html',
  styleUrls: ['./manage-blog.component.css']
})
export class ManageBlogComponent {
  ListBlog: TinTuc[] = [];

  p: number = 1;
  pageSize: number = 10;
  totalItems: number = 0;

  MaTT:any;
  AnhDaiDien: any;
  TieuDe: string = '';
  NgayDang: string = '';
  NoiDung: string = '';
  TrangThai = '1';
  MaND:any;
  HoTen: string = '';

  user: any;

  //tổng bản ghi
  totalRecords: number = 0;
  
  //Tìm kiếm
  search: string = '';
  
  previewImageUrl: string | ArrayBuffer | null = null;

  @ViewChild('scroll') scroll!: ElementRef;

  //Mở/đóng modal khi chưa selectedRow
  openModal: boolean = false;
  @ViewChild('modalCreate') modalCreate!: ElementRef;
  @ViewChild('modalDetail') modalDetail!: ElementRef;
  @ViewChild('modalUpdate') modalUpdate!: ElementRef;
  @ViewChild('fileInputC') fileInputC!: ElementRef; 
  @ViewChild('fileInputU') fileInputU!: ElementRef; 

  editorConfig: AngularEditorConfig = {
    editable: true,
    spellcheck: true,
    height: '40rem',
    minHeight: '5rem',
    placeholder: 'Nhập nội dung..',
    translate: 'no',
    defaultParagraphSeparator: 'p',
    defaultFontName: 'Arial'
  };
  
  constructor(private blogService:BlogService, private authenticateService: AuthenticateService) { }

  ngOnInit(){
    this.getListBlog(this.p);
    this.user = this.authenticateService.checkLogin();
  }

  getListBlog(p: number) {
    const obj = {
      page: p,
      pageSize: this.pageSize,
      tieuDe: this.search
    }
    this.blogService.getAllAdmin(obj).subscribe(res => {
      this.ListBlog = res.data;
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
  selectedRow: TinTuc | null = null;
  onRowClick(tintuc: TinTuc) {
    this.selectedRow = tintuc;
    this.MaTT = this.selectedRow.maTT;
    this.AnhDaiDien = this.selectedRow.anhDaiDien;
    this.TieuDe = this.selectedRow.tieuDe;
    this.NgayDang = this.selectedRow.ngayDang;
    this.NoiDung = this.selectedRow.noiDung;
    this.TrangThai = this.selectedRow.trangThai.toString();
    this.MaND = this.selectedRow.maND;
    this.HoTen = this.selectedRow.hoTen;
  }

  //mở form tạo mới
  showCreate(){
    this.AnhDaiDien = '';
    this.TieuDe = '';
    this.NoiDung = '';
    this.TrangThai = '1';
    this.selectedRow = null;
  }
  //mở form chi tiết
  showDetail() {
    if (!this.selectedRow) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng chọn một dòng để xem chi tiết!',
        icon: 'warning'
      });
      this.openModal = false;
    }
    else {
      this.openModal = true;
    }
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


  //làm mới
  refresh() {
    this.TieuDe = '';
    this.NoiDung = '';
    this.TrangThai = '1';
    this.previewImageUrl = null;
    // Đặt lại giá trị của input file
    if (this.fileInputC) {
      this.fileInputC.nativeElement.value = '';
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
      this.AnhDaiDien = fileList[0];
      const reader = new FileReader(); // Tạo một đối tượng FileReader để đọc dữ liệu của tệp
      reader.onload = () => {
        // Gán URL dữ liệu của ảnh vào biến previewImageUrl
        this.previewImageUrl = reader.result;
      };
      // Đọc tệp ảnh dưới dạng URL dữ liệu (data URL)
      reader.readAsDataURL(this.AnhDaiDien);
    }
  }

  //Thêm
  create() {
    if (!this.AnhDaiDien || !this.TieuDe || !this.NoiDung) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin (*)',
        icon: 'warning'
      });
      return;
    }

    const formData = new FormData();
    formData.append('File', this.AnhDaiDien!);
    formData.append('tieuDe', this.TieuDe);
    formData.append('noiDung', this.NoiDung);
    formData.append('trangThai', this.TrangThai);
    formData.append('maND', this.user.maND);
  
    this.blogService.create(formData).subscribe(res => {
      Swal.fire({
        title: 'Thành công',
        text: 'Tạo tin tức thành công!',
        icon: 'success'
      }).then(() => {
          this.getListBlog(this.p); //refresh

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
      if (!this.AnhDaiDien || !this.TieuDe || !this.NoiDung) {
        Swal.fire({
          title: 'Thông báo',
          text: 'Vui lòng nhập đầy đủ thông tin (*)',
          icon: 'warning'
        });
        return;
      }
      
    const formData = new FormData();
    formData.append('maTT', this.MaTT);
    formData.append('File', this.AnhDaiDien!);
    formData.append('tieuDe', this.TieuDe);
    formData.append('noiDung', this.NoiDung);
    formData.append('trangThai', this.TrangThai);
    formData.append('maND', this.user.maND);
      
      // Gọi phương thức sửa từ service
      this.blogService.update(formData).subscribe(res => {
        Swal.fire({
          title: 'Thành công',
          text: 'Cập nhật tin tức thành công!',
          icon: 'success'
        }).then(() => {
          this.selectedRow = null;
          this.getListBlog(this.p);
          
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
      const id = this.selectedRow.maTT;
      Swal.fire({
        title: 'Thông báo',
        text: 'Bạn có chắc chắn muốn xóa tin tức này?',
        icon: 'warning',
        showCancelButton: true,
        cancelButtonText: 'Hủy'
      }).then((result) => {
        if (result.isConfirmed) {
          this.blogService.delete(id).subscribe(res => {
            Swal.fire({
              title: 'Thông báo',
              text: 'Xóa tin tức thành công!',
              icon: 'success'
            }).then(() => {
              this.selectedRow = null;
              this.getListBlog(this.p);
            });
          });
        } 
        else if (result.dismiss === Swal.DismissReason.cancel) {
          this.selectedRow = null;
          this.getListBlog(this.p);
        }
      });
    }
  }
}
