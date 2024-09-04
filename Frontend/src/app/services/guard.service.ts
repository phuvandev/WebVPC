import { Injectable } from '@angular/core';
import { RouterStateSnapshot, Router, ActivatedRouteSnapshot } from '@angular/router';
import { AuthenticateService } from './authenticate.service';

import Swal from 'sweetalert2';
import { __assign } from 'tslib';

@Injectable({
  providedIn: 'root',
})
export class AuthGuard {
    constructor(private authenticateService:AuthenticateService, private router: Router) {}

    canActivate(next:ActivatedRouteSnapshot, state: RouterStateSnapshot): boolean {
        if (this.authenticateService.isAuthenticated()) {
            const user = this.authenticateService.getCurrentUser();
            if (user) {
                if (user.maQuyen === 1) {
                    return true;
                }
                else if(user.maQuyen === 2) {
                    if(state.url === '/admin/quan-ly-nhan-vien' || state.url === '/admin/quan-ly-khach-hang' || state.url === '/admin/quan-ly-quyen') {
                        Swal.fire({
                            title: 'Thông báo',
                            text: 'Bạn không có quyền truy cập trang này!',
                            icon: 'warning',
                            confirmButtonText: 'OK'
                        }).then(() => {
                            this.router.navigate(['/admin']);
                        });
                        return false;
                    }
                    else {
                        return true;
                    }
                } 
                else { 
                    // Cho phép truy cập các trang cụ thể cho khách hàng
                    if (state.url === '/tai-khoan' || state.url === '/thanh-toan') {
                        return true;
                    } else {
                        this.router.navigate(['/dang-nhap']); 
                        return false;
                    }
                }
            }
        }
        this.router.navigate(['/dang-nhap']);
        return false;
    }
}