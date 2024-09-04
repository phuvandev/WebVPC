import { Component } from '@angular/core';
import { AbstractControl, FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthenticateService } from 'src/app/services/authenticate.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent {
  registerForm: FormGroup;

  constructor(private authenticateService: AuthenticateService, private router: Router) {
    this.registerForm = new FormGroup(
      {
        hoTen: new FormControl('', [Validators.required, Validators.minLength(5)]),
        taiKhoan: new FormControl('', [Validators.required, Validators.minLength(5)]),
        email: new FormControl('', [Validators.required, Validators.pattern('^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$')]),
        matKhau: new FormControl('', [Validators.required, Validators.pattern('(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$!%*?&#])[A-Za-z\d$@$!%*?&#].{7,}')]),
        xacNhanMatKhau: new FormControl('', [Validators.required]),
        sdt: new FormControl('', [Validators.required, Validators.pattern(/^(84|0[3|5|7|8|9])[0-9]{8}$/)])
      },
      {
        validators: this.passwordMatchValidator
      }
    );
  }

  passwordMatchValidator(control: AbstractControl) {
    const password = control.get('matKhau');
    const confirmPassword = control.get('xacNhanMatKhau');
    if (password && confirmPassword && password.value !== confirmPassword.value) {
      confirmPassword.setErrors({ missMatch: true });
    } else if (confirmPassword) {
      confirmPassword.setErrors(null);
    }
    return null;
  }
  
  ngOnInit() {}

  register() {
    if (this.registerForm.invalid) {
      Swal.fire({
        icon: 'error',
        title: 'Có lỗi xảy ra',
        text: 'Đăng ký không hợp lệ, vui lòng điền đầy đủ thông tin!'
      });
      return;
    }
    this.authenticateService.checkExist(this.registerForm.value).subscribe(res => {
      if (res.status == 200) {
        this.authenticateService.register(this.registerForm.value).subscribe(res => {
          if (res) {
            Swal.fire({
              icon: 'success',
              title: 'Đăng ký thành công!',
              showConfirmButton: false,
              timer: 1500,
              timerProgressBar: true,
              didOpen: () => {
                Swal.showLoading();
              }
            }).then(() => {
              this.router.navigate(['/dang-nhap']);
            });
          }
        });
      } else {
        Swal.fire({
          icon: 'error',
          title: 'Có lỗi xảy ra',
          text: 'Tài khoản hoặc email bạn nhập đã tồn tại!'
        });
      }
    });
  }
}
