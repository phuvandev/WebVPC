import { Component, ElementRef, ViewChild } from '@angular/core';
import { Quyen } from 'src/app/models/role.model';
import { NguoiDung } from 'src/app/models/user.model';
import { AuthenticateService } from 'src/app/services/authenticate.service';
import { RoleService } from 'src/app/services/role.service';
import { SettingService } from 'src/app/services/setting.service';
import { UserService } from 'src/app/services/user.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-staff',
  templateUrl: './manage-staff.component.html',
  styleUrls: ['./manage-staff.component.css']
})
export class ManageStaffComponent {
  ListStaff: NguoiDung[] = [];
  ListRole: Quyen[] = [];

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
  TrangThai: string = '';
  MaQuyen: any;
  TenQuyen: string = '';

  p: number = 1;
  pageSize: number = 10;
  totalItems: number = 0;

  //Tìm kiếm
  search: string = '';

  previewImageUrl: string | ArrayBuffer | null = null;

  PasswordDefault = '';

  user:any;

  @ViewChild('scroll') scroll!: ElementRef;

  //Mở/đóng modal khi chưa selectedRow
  openModal: boolean = false;
  @ViewChild('modalCreate') modalCreate!: ElementRef;
  @ViewChild('modalUpdate') modalUpdate!: ElementRef;
  @ViewChild('fileInputC') fileInputC!: ElementRef; 
  @ViewChild('fileInputU') fileInputU!: ElementRef; 

  constructor(private staffService:UserService, private roleService: RoleService, private settingService:SettingService, private authenticateService:AuthenticateService) { }
  ngOnInit(){
    this.user = this.authenticateService.checkLogin();

    this.getListStaff(this.p);
    this.getListRole();
    this.getDefaultPassword();
  }

  getListStaff(p: number) {
    const obj = {
      page: p,
      pageSize: this.pageSize,
      hoTen: this.search
    }
    this.staffService.getAllStaff(obj).subscribe(res => {
      this.ListStaff = res.data;
      this.totalItems = res.totalItems;
      this.p = p;
      setTimeout(() => {
        if (this.scroll && this.scroll.nativeElement) {
          this.scroll.nativeElement.scrollIntoView({ behavior: 'smooth' });
        }
      }, 0);
    });
  }

  getListRole() {
    this.roleService.getAllAdmin().subscribe(res => {
      this.ListRole = res.data;
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
  onRowClick(staff: NguoiDung) {
    this.selectedRow = staff;
    this.MaND = this.selectedRow.maND;
    this.TaiKhoan = this.selectedRow.taiKhoan;
    this.Email = this.selectedRow.email;
    this.HoTen = this.selectedRow.hoTen;
    this.NgaySinh = this.formatDate(this.selectedRow.ngaySinh);
    this.GioiTinh = this.selectedRow.gioiTinh;
    this.AnhDaiDien = this.selectedRow.anhDaiDien;
    this.DiaChi = this.selectedRow.diaChi;
    this.SDT = this.selectedRow.sdt;
    this.TrangThai = this.selectedRow.trangThai.toString();
    this.MaQuyen = this.selectedRow.maQuyen;
    this.TenQuyen = this.selectedRow.tenQuyen;
  }

  //mở form tạo mới
  showCreate(){
    this.TaiKhoan = '';
    this.Email = '';
    this.HoTen = '';
    this.NgaySinh = '';
    this.GioiTinh = 'Nam';
    this.AnhDaiDien = '';
    this.DiaChi = '';
    this.TrangThai = '1';
    this.MaQuyen = '';
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
    const passwordPattern = new RegExp('(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&].{8,}');
    const phoneRegex = /(84|0[3|5|7|8|9])+([0-9]{8})\b/;
      
    if (!this.TaiKhoan || !this.MatKhau || !this.XacNhanMatKhau || !this.Email || !this.HoTen || !this.NgaySinh || !this.GioiTinh || !this.AnhDaiDien || !this.DiaChi || !this.SDT || !this.MaQuyen || !this.TrangThai) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin (*)',
        icon: 'warning'
      });
      return;
    }  
    else if (this.MatKhau !== this.XacNhanMatKhau) {
      Swal.fire({
        icon: 'error',
        title: 'Lỗi',
        text: 'Xác nhận mật khẩu không trùng khớp!'
      });
      return;
    } 
    else if (!passwordPattern.test(this.MatKhau)) {
      Swal.fire({
        icon: 'error',
        title: 'Lỗi',
        html: 'Mật khẩu không đáp ứng yêu cầu bảo mật!<br> Độ dài cần ít nhất 8 ký tự (chữ viết thường, in hoa, số, ký tự)'
      });
      return;
    }
    else if (!phoneRegex.test(this.SDT)) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Số điện thoại không hợp lệ, vui lòng nhập lại!',
        icon: 'warning'
      });
      return;
    }
    else {
      //Kiểm tra nhật khẩu mới có trùng không
      if(this.MatKhau === this.XacNhanMatKhau){

        const formData = new FormData();
        formData.append('taiKhoan', this.TaiKhoan);
        formData.append('matKhau', this.MatKhau);
        formData.append('email', this.Email)
        formData.append('hoTen', this.HoTen)
        formData.append('ngaySinh', this.NgaySinh)
        formData.append('gioiTinh', this.GioiTinh)
        formData.append('File', this.AnhDaiDien!);
        formData.append('diaChi', this.DiaChi)
        formData.append('sdt', this.SDT)
        formData.append('trangThai', this.TrangThai);
        formData.append('maQuyen', this.MaQuyen);

        this.staffService.create(formData).subscribe(res => {
          Swal.fire({
            title: 'Thành công',
            text: 'Thêm nhân viên thành công!',
            icon: 'success'
          }).then(() => {
            this.getListStaff(this.p); //refresh

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
    }
  }
  
  //Sửa
  update() {
    if (this.selectedRow) {
      if (!this.Email || !this.HoTen || !this.NgaySinh || !this.DiaChi || !this.SDT || !this.MaQuyen) {
        Swal.fire({
          title: 'Thông báo',
          text: 'Vui lòng nhập đầy đủ thông tin (*)',
          icon: 'warning'
        });
        return;
      } 
      else {
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

        const formData = new FormData();
        formData.append('maND', this.MaND);
        formData.append('email', this.Email)
        formData.append('hoTen', this.HoTen)
        formData.append('ngaySinh', this.NgaySinh)
        formData.append('gioiTinh', this.GioiTinh)
        formData.append('File', this.AnhDaiDien!);
        formData.append('diaChi', this.DiaChi)
        formData.append('sdt', this.SDT)
        formData.append('trangThai', this.TrangThai);
        formData.append('maQuyen', this.MaQuyen);

        this.staffService.update(formData).subscribe(res => {
          Swal.fire({
            title: 'Thành công',
            text: 'Cập nhật thông tin nhân viên thành công!',
            icon: 'success'
          }).then(() => {
            this.getListStaff(this.p); //refresh
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
    }
  }

  //Xóa
  delete() {
    if (this.selectedRow) {
      const id = this.selectedRow.maND;
      Swal.fire({
        title: 'Thông báo',
        text: 'Bạn có chắc chắn muốn xóa nhân viên này?',
        icon: 'warning',
        showCancelButton: true,
        cancelButtonText: 'Hủy'
      }).then((result) => {
        if (result.isConfirmed) {
          this.staffService.delete(id).subscribe(res => {
            Swal.fire({
              title: 'Thông báo',
              text: 'Xóa nhân viên thành công!',
              icon: 'success',
              confirmButtonText: 'Đóng', 
            }).then(() => {
              this.selectedRow = null;
              this.getListStaff(this.p);
            });
          }, error => {
            Swal.fire({
              icon: 'error',
              title: 'Lỗi',
              text: "Không thể xoá nhân viên này!"
            }).then(() => {
              this.selectedRow = null;
              this.getListStaff(this.p);
            });
          });
        } 
        else if (result.dismiss === Swal.DismissReason.cancel) {
          this.selectedRow = null;
          this.getListStaff(this.p);
        }
      });
    }
  }
  
  getDefaultPassword() {
    this.settingService.getBySign('PASSWORD_STAFF').subscribe(res => { 
      this.PasswordDefault = res.data.moTa;
    });
  }

  //Đặt lại mật khẩu
  resetPassword() {
    if(this.selectedRow) {
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
              formData.append('matKhau', this.PasswordDefault);

              this.staffService.update(formData).subscribe(res => {
                Swal.fire({
                  title: 'Thành công',
                  text: 'Thay đổi mật khẩu thành công!',
                  icon: 'success'
                }).then(() => {
                  this.getListStaff(this.p); //refresh
                });
              });
            }
          });
        }
      }).then((result) => {
        if (result.dismiss === Swal.DismissReason.cancel) {
          this.selectedRow = null;
          this.getListStaff(this.p);
        }
      });
    } else {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng chọn một dòng để thực hiện!',
        icon: 'warning'
      });
    }
  }
}
