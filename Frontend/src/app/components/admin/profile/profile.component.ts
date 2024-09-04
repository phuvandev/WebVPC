import { Component, ElementRef, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { AuthenticateService } from 'src/app/services/authenticate.service';
import { UserService } from 'src/app/services/user.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent {
  user:any;

  nameUser:string = '';
  avatar:any;

  //thay đổi mật khẩu
  MatKhauCu:string = '';
  MatKhauMoi: string = '';
  XacNhanMatKhau: string = '';
  
  previewImageUrl: string | ArrayBuffer | null = null;

  @ViewChild('fileInput') fileInput!: ElementRef; 

  constructor(private authenticateService:AuthenticateService, private userService:UserService, private router:Router) {}

  ngOnInit() {
    this.user = this.authenticateService.checkLogin();
    this.avatar = this.authenticateService.checkLogin().anhDaiDien;
    this.nameUser = this.authenticateService.checkLogin().hoTen;

    //format ngày sinh user
    this.user.ngaySinh = this.formatDate(this.user.ngaySinh);
  }

  //format ngay/thang/nam
  formatDate(date: string): string {
    const originalDate = new Date(date);
    originalDate.setDate(originalDate.getDate() + 1);
    const formattedDate = originalDate.toISOString().slice(0, 10);
    return formattedDate;
  }
  

  // Xử lý khi người dùng chọn một tệp ảnh
  onFileChange(event: any) {
    const fileList: FileList = event.target.files;// Lấy danh sách các tệp được chọn từ sự kiện change
    if (fileList.length > 0) {
      this.user.anhDaiDien = fileList[0];
      const reader = new FileReader(); // Tạo một đối tượng FileReader để đọc dữ liệu của tệp
      reader.onload = () => {
        // Gán URL dữ liệu của ảnh vào biến previewImageUrl
        this.previewImageUrl = reader.result;
      };
      // Đọc tệp ảnh dưới dạng URL dữ liệu (data URL)
      reader.readAsDataURL(this.user.anhDaiDien);
    }
  }

  updateGeneral() {
    if (!this.user.hoTen || !this.user.ngaySinh || !this.user.diaChi || !this.user.sdt) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin (*)',
        icon: 'warning'
      });
      return;
    }
    
    // Kiểm tra số điện thoại
    const phoneRegex = /(84|0[3|5|7|8|9])+([0-9]{8})\b/;
    if (!phoneRegex.test(this.user.sdt)) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Số điện thoại không hợp lệ, vui lòng nhập lại!',
        icon: 'warning'
      });
      return;
    }

    Swal.fire({
      title: 'Xác nhận mật khẩu',
      input: 'password',
      inputPlaceholder: 'Nhập mật khẩu của bạn!',
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
            // Tạo một đối tượng từ dữ liệu được chọn
            const formData = new FormData();
            formData.append('maND', this.user.maND);
            formData.append('hoTen', this.user.hoTen);
            formData.append('ngaySinh', this.user.ngaySinh);
            formData.append('gioiTinh', this.user.gioiTinh);
            formData.append('diaChi', this.user.diaChi);
            formData.append('sdt', this.user.sdt);
            if (this.user.anhDaiDien) {
              formData.append('File', this.user.anhDaiDien);
            }
            this.userService.update(formData).subscribe(res => {
              Swal.fire({
                title: 'Thành công',
                text: 'Thay đổi thông tin thành công, website sẽ tự động đăng xuất!',
                icon: 'success',
                showConfirmButton: false,
                timer: 1500,
                timerProgressBar: true,
                didOpen: () => {
                  Swal.showLoading();
                }
              }).then(() => {
                localStorage.clear();
                this.router.navigate(['/dang-nhap']);
              });
            });
          }
        });
      }
    });
  }

  updatePassword() {
    const passwordPattern = new RegExp('(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&].{8,}');
  
    if (!this.MatKhauCu || !this.MatKhauMoi || !this.XacNhanMatKhau) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin (*)',
        icon: 'warning'
      });
      return;
    } else if (this.MatKhauMoi !== this.XacNhanMatKhau) {
      Swal.fire({
        icon: 'error',
        title: 'Lỗi',
        text: 'Xác nhận mật khẩu không trùng khớp!'
      });
      return;
    } else if (!passwordPattern.test(this.MatKhauMoi)) {
      Swal.fire({
        icon: 'error',
        title: 'Lỗi',
        html: 'Mật khẩu mới không đáp ứng yêu cầu bảo mật!<br> Độ dài cần ít nhất 8 ký tự (chữ viết thường, in hoa, số, ký tự)'
      });
      return;
    } else if (this.MatKhauMoi === this.MatKhauCu) {
      Swal.fire({
        icon: 'error',
        title: 'Lỗi',
        text: 'Mật khẩu mới phải khác mật khẩu hiện tại!'
      });
      return;
    } else {
      const check: any = {
        taiKhoan: this.user.taiKhoan,
        matKhau: this.MatKhauCu
      };
  
      this.authenticateService.login(check).subscribe(res => {
        if (res.status === 404) {
          Swal.fire({
            icon: 'error',
            title: 'Lỗi',
            text: 'Mật khẩu hiện tại của bạn chưa chính xác!'
          });
        } else {
          // Đổi mật khẩu
          const formData = new FormData();
          formData.append('maND', this.user.maND);
          formData.append('matKhau', this.MatKhauMoi);
  
          this.userService.update(formData).subscribe(res => {
            Swal.fire({
              title: 'Thành công',
              text: 'Thay đổi mật khẩu thành công, website sẽ tự động đăng xuất!',
              icon: 'success',
              showConfirmButton: false,
              timer: 1500,
              timerProgressBar: true,
              didOpen: () => {
                Swal.showLoading();
              }
            }).then(() => {
              localStorage.clear();
              this.router.navigate(['/dang-nhap']);
            });
          });
        }
      });
    }
  }
}
