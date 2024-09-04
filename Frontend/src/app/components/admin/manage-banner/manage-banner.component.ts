import { Component, ElementRef, ViewChild } from '@angular/core';
import { Banner } from 'src/app/models/banner.model';
import { BannerService } from 'src/app/services/banner.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-banner',
  templateUrl: './manage-banner.component.html',
  styleUrls: ['./manage-banner.component.css']
})
export class ManageBannerComponent {
  ListBanner: Banner[] = [];
  MaBanner:any;
  Anh: any;
  Link: string = '';
  TrangThai = '1';
  previewImageUrl: string | ArrayBuffer | null = null;

  //Mở/đóng modal khi chưa selectedRow
  openModal: boolean = false;
  @ViewChild('modalCreate') modalCreate!: ElementRef;
  @ViewChild('modalUpdate') modalUpdate!: ElementRef;
  @ViewChild('fileInputC') fileInputC!: ElementRef; 
  @ViewChild('fileInputU') fileInputU!: ElementRef; 

  constructor(private bannerService:BannerService) { }
  ngOnInit(){
    this.getListBanner();
  }

  getListBanner() {
    this.bannerService.getAllAdmin().subscribe(res => {
      this.ListBanner = res.data;
    });
  }

  // Xử lý khi ấn vào dòng
  selectedRow: Banner | null = null;
  onRowClick(banner: Banner) {
    this.selectedRow = banner;
    this.MaBanner = this.selectedRow.maBanner;
    this.Anh = this.selectedRow.anh;
    this.Link = this.selectedRow.link;
    this.TrangThai = this.selectedRow.trangThai.toString();
  }

  //mở form tạo mới
  showCreate(){
    this.Anh = '';
    this.Link = '';
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
      this.Anh = fileList[0];
      const reader = new FileReader(); // Tạo một đối tượng FileReader để đọc dữ liệu của tệp
      reader.onload = () => {
        // Gán URL dữ liệu của ảnh vào biến previewImageUrl
        this.previewImageUrl = reader.result;
      };
      // Đọc tệp ảnh dưới dạng URL dữ liệu (data URL)
      reader.readAsDataURL(this.Anh);
    }
  }

  //Thêm
  create() {
    if (!this.Anh || !this.Link || !this.TrangThai) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin (*)',
        icon: 'warning'
      });
      return;
    }

    const formData = new FormData();
    formData.append('File', this.Anh!);
    formData.append('link', this.Link)
    formData.append('trangThai', this.TrangThai);
  
    this.bannerService.create(formData).subscribe(res => {
      Swal.fire({
        title: 'Thành công',
        text: 'Tạo banner thành công!',
        icon: 'success'
      }).then(() => {
          this.getListBanner(); //refresh

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
      if (!this.Anh || !this.Link) {
        Swal.fire({
          title: 'Thông báo',
          text: 'Vui lòng nhập đầy đủ thông tin (*)',
          icon: 'warning'
        });
        return;
      }

      const formData = new FormData();
      formData.append('maBanner', this.MaBanner);
      formData.append('File', this.Anh!);
      formData.append('link', this.Link);
      formData.append('trangThai', this.TrangThai);
      
      // Gọi phương thức sửa từ service
      this.bannerService.update(formData).subscribe(res => {
        Swal.fire({
          title: 'Thành công',
          text: 'Cập nhật banner thành công!',
          icon: 'success'
        }).then(() => {
          this.selectedRow = null;
          this.getListBanner();
          
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
      const id = this.selectedRow.maBanner;
      Swal.fire({
        title: 'Thông báo',
        text: 'Bạn có chắc chắn muốn xóa banner này?',
        icon: 'warning',
        showCancelButton: true,
        cancelButtonText: 'Hủy'
      }).then((result) => {
        if (result.isConfirmed) {
          this.bannerService.delete(id).subscribe(res => {
            Swal.fire({
              title: 'Thông báo',
              text: 'Xóa banner thành công!',
              icon: 'success'
            }).then(() => {
              this.selectedRow = null;
              this.getListBanner();
            });
          });
        } 
        else if (result.dismiss === Swal.DismissReason.cancel) {
          this.selectedRow = null;
          this.getListBanner();
        }
      });
    }
  }
}