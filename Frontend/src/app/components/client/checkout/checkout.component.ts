import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { PaymentInformation } from 'src/app/models/otherPayment.model';
import { AuthenticateService } from 'src/app/services/authenticate.service';
import { CartService } from 'src/app/services/cart.service';
import { OrderService } from 'src/app/services/order.service';
import { OtherPaymentService } from 'src/app/services/otherPayment.service';
import { ProductService } from 'src/app/services/product.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-checkout',
  templateUrl: './checkout.component.html',
  styleUrls: ['./checkout.component.css']
})
export class CheckoutComponent {
  PaymentInformation: PaymentInformation[] = [];

  TenKH: string = '';
  Email: string = '';
  SDT: string = '';
  DiaChiGiaoHang: string = '';
  GhiChu: string = '';
  MaND: number = 0;
  PhuongThucThanhToan: string = '';
  TrangThai: number = 0;
  dataCus: any;

  ListCart: any;
  TotalQuantity: number = 0;
  TotalPrice: number = 0;

  MaDH: any;

  constructor(private authenticateService:AuthenticateService, private orderService:OrderService, private otherPayment: OtherPaymentService, private router:Router, private cartService: CartService, private productService:ProductService) {}

  ngOnInit(){
    this.dataCustomer();
    this.loadInfoCart();
  }

  dataCustomer() {
    this.dataCus = this.authenticateService.checkLogin();
    if(this.dataCus) {
      this.MaND = this.dataCus.maND;
      this.TenKH = this.dataCus.hoTen;
      this.Email = this.dataCus.email;
      this.SDT = this.dataCus.sdt;
      this.DiaChiGiaoHang = this.dataCus.diaChi;
      this.GhiChu = this.dataCus.ghiChu;
    }
  }

  loadInfoCart() {
    let cart: any[] = JSON.parse(localStorage.getItem('cart') || '[]');
    this.ListCart = cart;
    this.TotalQuantity = cart.reduce((total, item) => total + item.SoLuong, 0);
    this.TotalPrice = cart.reduce((total, item) => total + (item.GiaBan * item.SoLuong), 0);
  }

  //Kiểm tra thông tin để tiến hành đặt hàng
  checkInfoCustom():boolean{
    if (this.TenKH == ""  || this.Email == "" || this.SDT == "" || this.DiaChiGiaoHang == "") {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin (*)',
        icon: 'warning',
      });
      return false;
    }
    else if (!this.PhuongThucThanhToan) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng chọn phương thức thanh toán!',
        icon: 'warning',
      });
      return false;
    }
    return true;
  }

  //Thanh toán online
  vnPay(id: number){
    const payment: PaymentInformation = {
      orderId: id,
      name: this.TenKH,
      amount: this.TotalPrice,
      orderDescription: this.GhiChu ? this.GhiChu : '',
      orderType: "other",
      url: `${window.location.origin}/thanh-toan-chuyen-khoan`
    }

    this.otherPayment.vnPay(payment).subscribe(res => { 
      if(res.success){
        window.location.href = res.data;
      }
      else{
        Swal.fire({
          icon: 'warning',
          title: 'Cảnh báo',
          text: res.message
        });
      }
    });
  }

  orderNow() {
    //sản phẩm đủ số lượng
    let checkQuantity = false;
  
    if (this.checkInfoCustom()) {
      // Sử dụng Promise.all để đợi cho tất cả các lời gọi subscribe hoàn tất
      Promise.all(this.ListCart.map((item: { MaSP: number; }) => 
        this.productService.getOne(item.MaSP).toPromise()
      )).then(res => {
        // Duyệt qua từng sản phẩm trong giỏ hàng và kiểm tra số lượng
        res.forEach((res, index) => {
          //duyệt qua từng sản phẩm, cùng với chỉ số tương ứng.
          const item = this.ListCart[index];
          const totalQuantity = item.SoLuong;
          // So sánh số lượng trong giỏ hàng với số lượng thực tế của sản phẩm
          if (totalQuantity > res.data.soLuong) {
            Swal.fire({
              icon: 'warning',
              title: 'Thông báo',
              text: 'Sản phẩm vừa chọn không đủ số lượng, vui lòng kiểm tra lại !'
            }).then(() => {
              this.router.navigate(['/gio-hang']);
            });
            // Đánh dấu có ít nhất một sản phẩm không đủ số lượng
            checkQuantity = true;
          }
        });
  
        // Sản phẩm đủ số lượng
        if (!checkQuantity) {
          const obj: {
            tenKH: string,
            email: string,
            diaChiGiaoHang: string,
            sdt: string,
            ghiChu: string,
            phuongThucThanhToan: string,
            trangThai: number,
            maND: number,
            listjson_chitietdonhang: { soLuong: number, giaBan: number, maSP: number }[];
          } = {
            //trái: postman >< phải: ngModel
            tenKH: this.TenKH,
            email: this.Email,
            diaChiGiaoHang: this.DiaChiGiaoHang,
            sdt: this.SDT,
            ghiChu: this.GhiChu,
            phuongThucThanhToan: this.PhuongThucThanhToan,
            trangThai: this.PhuongThucThanhToan === 'Chuyển khoản' ? 2 : 0,
            maND: this.MaND,
            listjson_chitietdonhang: []
          };
  
          for (const product of this.ListCart) {
            obj.listjson_chitietdonhang.push({
              soLuong: product.SoLuong,
              giaBan: product.GiaBan,
              maSP: product.MaSP
            });
          }
          
          // Tạo đơn hàng mới và gửi email
          this.orderService.create(obj).subscribe(() => {
            this.orderService.getOneNew().subscribe(res => {
              // Gửi email
              const email: any = {
                email: this.Email,
                maDH: res.data.maDH
              };
              this.orderService.sendOrderEmail(email).subscribe(res => {});
  
              if (this.PhuongThucThanhToan == 'Giao hàng tận nơi') {
                Swal.fire({
                  title: 'Đặt hàng thành công!',
                  text: 'Cảm ơn quý khách đã mua hàng trên hệ thống!',
                  icon: 'success',
                  timer: 1500,
                  timerProgressBar: true,
                  didOpen: () => {
                    Swal.showLoading();
                  }
                }).then(() => {
                  localStorage.removeItem('cart');
                  this.cartService.loadAfterPayment();
                  this.router.navigate(['/']);
                });
              } else {
                this.vnPay(res.data.maDH);
                localStorage.removeItem('cart');
              }
            });
          });
        }
      });
    }
  }
  
}


// error => {
// console.error('Error during payment:', error);
// Swal.fire('Lỗi', 'Đã xảy ra lỗi trong quá trình thanh toán', 'error');