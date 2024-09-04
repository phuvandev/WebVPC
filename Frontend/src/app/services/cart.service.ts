import { Injectable } from '@angular/core';
import { ProductService } from './product.service';
import { Subject } from 'rxjs';

import Swal from 'sweetalert2';

@Injectable({
  providedIn: 'root',
})
export class CartService {
    cartUpdated = new Subject<void>();

    constructor(private productService: ProductService) {}

    addToCart(id: number, quantity: number) {
        this.productService.getOne(id).subscribe(res => {
            const sanpham = {
                MaSP: res.data.maSP,
                TenSP: res.data.tenSP,
                AnhDaiDien: res.data.anhDaiDien,
                SoLuong: quantity,
                GiaBan: res.data.giaSauGiam
            };
            
            let cart: any[] = JSON.parse(localStorage.getItem('cart') || '[]');
            
            const existingItem = cart.find((item: any) => item.MaSP === sanpham.MaSP);
    
            if (existingItem) {
                const totalQuantity = existingItem.SoLuong + quantity;
                if (totalQuantity > res.data.soLuong) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Thông báo',
                        text: 'Bạn không thể mua quá số lượng có sẵn!',
                        confirmButtonText: 'OK'
                    });
                    return;
                }
                if (totalQuantity <= 5) {
                    existingItem.SoLuong += quantity;
                } 
                else {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Thông báo',
                        text: 'Số lượng sản phẩm đặt mua không được vượt quá 5 sản phẩm!',
                        confirmButtonText: 'OK'
                    });
                    return;
                }
            } else {
                cart.push({ ...sanpham });
            }
    
            localStorage.setItem('cart', JSON.stringify(cart));
            Swal.fire({
                title: 'Xử lý thành công',
                text: 'Đã thêm sản phẩm vào giỏ hàng!',
                icon: 'success'
            });
            this.cartUpdated.next();
        });
    }
    

    // Load giỏ hàng header
    loadCart() {
        let cart: any[] = JSON.parse(localStorage.getItem('cart') || '[]');
        var count = cart.reduce((total, item) => total + item.SoLuong, 0);

        return { Cart: cart, Count: count };
    }

    // Tăng số lượng sản phẩm trong giỏ hàng
    add(id: number) {
        let cart: any[] = JSON.parse(localStorage.getItem('cart') || '[]');
        const item = cart.find(item => item.MaSP === id);
    
        if (item) {
            this.productService.getOne(id).subscribe(res => {
                const totalQuantity = item.SoLuong + 1;
                if (totalQuantity > res.data.soLuong) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Thông báo',
                        text: 'Bạn không thể mua quá số lượng có sẵn!',
                        confirmButtonText: 'OK'
                    });
                    return;
                }
                if (item.SoLuong < 5) {
                    item.SoLuong += 1;
                    localStorage.setItem('cart', JSON.stringify(cart));
                    this.cartUpdated.next();
                } else {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Thông báo',
                        text: 'Số lượng sản phẩm đặt mua không được vượt quá 5 sản phẩm!',
                        confirmButtonText: 'OK'
                    });
                }
            });
        }
    }

    // Giảm số lượng sản phẩm trong giỏ hàng
    reduct(id: number) {
        let cart: any[] = JSON.parse(localStorage.getItem('cart') || '[]');
        const item = cart.find(item => item.MaSP === id);

        if (item) {
            if (item.SoLuong == 1) {
                Swal.fire({
                    title: 'Thông báo',
                    text: 'Bạn chắc chắn muốn bỏ sản phẩm này?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'OK',
                    cancelButtonText: 'Hủy'
                }).then((result) => {
                    if (result.isConfirmed) {
                        cart = cart.filter(cartItem => cartItem.MaSP !== id);
                        localStorage.setItem('cart', JSON.stringify(cart));
                        this.cartUpdated.next();
                    }
                });
            } else {
                item.SoLuong -= 1;
                localStorage.setItem('cart', JSON.stringify(cart));
                this.cartUpdated.next();
            }
        }
    }  

    // Xóa sản phẩm khỏi giỏ hàng
    delete(id: number) {
        Swal.fire({
            title: 'Thông báo',
            text: 'Bạn chắc chắn muốn bỏ sản phẩm này?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'OK',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                let cart: any[] = JSON.parse(localStorage.getItem('cart') || '[]');
                cart = cart.filter(item => item.MaSP !== id);
        
                localStorage.setItem('cart', JSON.stringify(cart));
                this.cartUpdated.next();
            }
        });
    }

    loadAfterPayment() {
        this.cartUpdated.next();
    }
}
