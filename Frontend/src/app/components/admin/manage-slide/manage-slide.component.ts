import { Component, ElementRef, ViewChild } from '@angular/core';
import { Slide } from 'src/app/models/slide.model';
import { SlideService } from 'src/app/services/slide.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-slide',
  templateUrl: './manage-slide.component.html',
  styleUrls: ['./manage-slide.component.css']
})
export class ManageSlideComponent {
  ListSlide: Slide[] = [];
  MaSlide:any;
  Anh: any;
  TrangThai = '1';
  previewImageUrl: string | ArrayBuffer | null = null;

  //Mở/đóng modal khi chưa selectedRow
  openModal: boolean = false;
  @ViewChild('modalCreate') modalCreate!: ElementRef;
  @ViewChild('modalUpdate') modalUpdate!: ElementRef;
  @ViewChild('fileInputC') fileInputC!: ElementRef; 
  @ViewChild('fileInputU') fileInputU!: ElementRef; 

  constructor(private slideService:SlideService) { }
  ngOnInit(){
    this.getListSlide();
  }

  getListSlide() {
    this.slideService.getAllAdmin().subscribe(res => {
      this.ListSlide = res.data;
    });
  }

  // Xử lý khi ấn vào dòng
  selectedRow: Slide | null = null;
  onRowClick(slide: Slide) {
    this.selectedRow = slide;
    this.MaSlide = this.selectedRow.maSlide;
    this.Anh = this.selectedRow.anh;
    this.TrangThai = this.selectedRow.trangThai.toString();
  }

  //mở form tạo mới
  showCreate(){
    this.Anh = '';
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
    if (!this.Anh || !this.TrangThai) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng chọn ảnh để thêm! (*)',
        icon: 'warning'
      });
      return;
    }

    const formData = new FormData();
    formData.append('File', this.Anh!);
    formData.append('trangThai', this.TrangThai);
  
    this.slideService.create(formData).subscribe(res => {
      Swal.fire({
        title: 'Thành công',
        text: 'Tạo slide thành công!',
        icon: 'success'
      }).then(() => {
          this.getListSlide(); //refresh

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
      if (!this.Anh) {
        Swal.fire({
          title: 'Thông báo',
          text: 'Vui lòng chọn ảnh để sửa (*)',
          icon: 'warning'
        });
        return;
      }
      const formData = new FormData();
      formData.append('maSlide', this.MaSlide);
      formData.append('File', this.Anh!);
      formData.append('trangThai', this.TrangThai);
      
      // Gọi phương thức sửa từ service
      this.slideService.update(formData).subscribe(res => {
        Swal.fire({
          title: 'Thành công',
          text: 'Cập nhật slide thành công!',
          icon: 'success'
        }).then(() => {
          this.selectedRow = null;
          this.getListSlide();
          
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
      const id = this.selectedRow.maSlide;
      Swal.fire({
        title: 'Thông báo',
        text: 'Bạn có chắc chắn muốn xóa slide này?',
        icon: 'warning',
        showCancelButton: true,
        cancelButtonText: 'Hủy'
      }).then((result) => {
        if (result.isConfirmed) {
          this.slideService.delete(id).subscribe(res => {
            Swal.fire({
              title: 'Thông báo',
              text: 'Xóa slide thành công!',
              icon: 'success'
            }).then(() => {
              this.selectedRow = null;
              this.getListSlide();
            });
          });
        } 
        else if (result.dismiss === Swal.DismissReason.cancel) {
          this.selectedRow = null;
          this.getListSlide();
        }
      });
    }
  }
}
