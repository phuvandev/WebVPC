import { Component } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthenticateService } from 'src/app/services/authenticate.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  loginForm:FormGroup = new FormGroup({
    taiKhoan: new FormControl('', Validators.required),
    matKhau: new FormControl('', Validators.required)
  });

  constructor(private authenticateService:AuthenticateService, private router:Router) {}
  
  login(){
    if(this.loginForm.invalid) {
      Swal.fire({
        icon: 'error',
        title: 'Thông báo',
        text: 'Thông tin đăng nhập không hợp lệ!'
      }); 
      return;    
    }
    this.authenticateService.login(this.loginForm.value).subscribe((res) => {
      if (res.status === 404) {
        Swal.fire({
          icon: 'error',
          title: 'Thông báo',
          text: 'Tên đăng nhập hoặc mật khẩu không tồn tại!'
        });
      } 
      else if (res.status === 403) {
        Swal.fire({
          icon: 'error',
          title: 'Thông báo',
          text: 'Tài khoản đang bị khóa, vui lòng liên hệ đội ngũ admin!'
        });
      }
      else {
        // bao gồm tất cả các thuộc tính từ res.resul + `loginTime`
        const jsondata = {
          ...res.result,
          loginTime: new Date().getTime()
        };

        // Lưu trữ dữ liệu người dùng ngay sau khi nhận được phản hồi từ service
        localStorage.setItem('user', JSON.stringify(jsondata));
        
        Swal.fire({
          icon: 'success',
          title: 'Đăng nhập thành công!',
          showConfirmButton: false,
          timer: 1500,
          timerProgressBar: true,
          didOpen: () => {
            Swal.showLoading();
          }
        }).then(() => {
          if(res.result.maQuyen == 1 || res.result.maQuyen == 2) {
            this.router.navigate(['/admin']);
          }
          else {
            this.router.navigate(['/']);
          }
        });
      }
    });
  }
}
