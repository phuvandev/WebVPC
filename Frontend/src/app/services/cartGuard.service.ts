import { Injectable } from '@angular/core';
import { RouterStateSnapshot, Router, ActivatedRouteSnapshot } from '@angular/router';
import Swal from 'sweetalert2';

@Injectable({
  providedIn: 'root'
})
export class CartGuard {

  constructor(private router: Router) {}

  canActivate(): boolean {
    const cart = JSON.parse(localStorage.getItem('cart') || '[]');
    if (cart.length === 0) {
        Swal.fire({
            icon: 'warning',
            title: 'Thông báo',
            text: 'Vui lòng thêm sản phẩm vào giỏ hàng!',
            confirmButtonText: 'OK',
        }).then(() => {
            this.router.navigate(['/gio-hang']);
        });
        return false;
    }
    else {
        return true;
    }
  }
}
