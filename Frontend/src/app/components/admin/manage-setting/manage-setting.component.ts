import { Component, ElementRef, ViewChild } from '@angular/core';
import { Setting } from 'src/app/models/setting.model';
import { SettingService } from 'src/app/services/setting.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-setting',
  templateUrl: './manage-setting.component.html',
  styleUrls: ['./manage-setting.component.css']
})
export class ManageSettingComponent {
  ListSetting: Setting[] = [];
  MaSetting:any;
  TenSetting: string = '';
  KyHieu: string = '';
  Anh: any;
  MoTa: string = '';

  p: number = 1;
  pageSize: number = 10;
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

  constructor(private settingService:SettingService) { }
  ngOnInit(){
    this.getListSetting(this.p);
  }

  getListSetting(p: number) {
    const obj = {
      page: p,
      pageSize: this.pageSize,
      tenSetting: this.search
    }
    this.settingService.getAllAdmin(obj).subscribe(res => {
      this.ListSetting = res.data;
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
  selectedRow: Setting | null = null;
  onRowClick(setting: Setting) {
    this.selectedRow = setting;
    this.MaSetting = this.selectedRow.maSetting;
    this.TenSetting = this.selectedRow.tenSetting;
    this.KyHieu = this.selectedRow.kyHieu;
    this.Anh = this.selectedRow.anh;
    this.MoTa = this.selectedRow.moTa;
  }

  //mở form tạo mới
  showCreate(){
    this.TenSetting = '';
    this.KyHieu = '';
    this.Anh = '';
    this.MoTa = '';
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
    if (!this.TenSetting || !this.KyHieu) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin (*)',
        icon: 'warning'
      });
      return;
    }

    const formData = new FormData();
    formData.append('tenSetting', this.TenSetting);
    formData.append('kyHieu', this.KyHieu);
    formData.append('File', this.Anh!);
    formData.append('moTa', this.MoTa);
  
    this.settingService.create(formData).subscribe(res => {
      Swal.fire({
        title: 'Thành công',
        text: 'Tạo setting thành công!',
        icon: 'success'
      }).then(() => {
          this.getListSetting(this.p); //refresh

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
      if (!this.TenSetting || !this.KyHieu) {
        Swal.fire({
          title: 'Thông báo',
          text: 'Vui lòng nhập đầy đủ thông tin (*)',
          icon: 'warning'
        });
        return;
      }
      const formData = new FormData();
      formData.append('maSetting', this.MaSetting);
      formData.append('tenSetting', this.TenSetting);
      formData.append('kyHieu', this.KyHieu);
      formData.append('File', this.Anh!);
      formData.append('moTa', this.MoTa);
      
      // Gọi phương thức sửa từ service
      this.settingService.update(formData).subscribe(res => {
        Swal.fire({
          title: 'Thành công',
          text: 'Cập nhật setting thành công!',
          icon: 'success'
        }).then(() => {
          this.selectedRow = null;
          this.getListSetting(this.p);
          
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
      const id = this.selectedRow.maSetting;
      Swal.fire({
        title: 'Thông báo',
        text: 'Bạn có chắc chắn muốn xóa setting này?',
        icon: 'warning',
        showCancelButton: true,
        cancelButtonText: 'Hủy'
      }).then((result) => {
        if (result.isConfirmed) {
          this.settingService.delete(id).subscribe(res => {
            Swal.fire({
              title: 'Thông báo',
              text: 'Xóa setting thành công!',
              icon: 'success'
            }).then(() => {
              this.selectedRow = null;
              this.getListSetting(this.p);
            });
          });
        } 
        else if (result.dismiss === Swal.DismissReason.cancel) {
          this.selectedRow = null;
          this.getListSetting(this.p);
        }
      });
    }
  }
}
