import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { CartService } from 'src/app/services/cart.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css']
})
export class CartComponent {
  ListCart: any[] = [];
  Count: number = 0;

  constructor(private cartService:CartService, private router:Router) {}
  ngOnInit() {
    this.cartService.cartUpdated.subscribe(() => {
      this.loadCart();
    });
    this.loadCart();
  }

  //Load giỏ hàng
  loadCart() {
    var cart = this.cartService.loadCart();
    this.ListCart = cart.Cart;
    this.Count = cart.Count;
  }

  // Tăng sl
  add(id: number) {
    this.cartService.add(id);
  }
  // Giảm sl
  reduct(id: number) {
    this.cartService.reduct(id);
  }
  //Xóa sl
  delete(id: number) {
    this.cartService.delete(id);
  }  
  //Tới trang thanh toán
  goToCheckout() {
    const user = localStorage.getItem('user');
    if (!user) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng đăng nhập để thực hiện thanh toán!',
        icon: 'warning',
        showCancelButton: true,
        cancelButtonText: 'Hủy'
      }).then((result) => {
        if (result.isConfirmed) { 
          this.router.navigate(['/dang-nhap']);
          return;
        }
      });
    }
    else {
      location.assign('/thanh-toan');
    } 
  }
}
