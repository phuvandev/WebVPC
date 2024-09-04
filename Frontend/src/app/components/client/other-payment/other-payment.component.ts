import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { OtherPaymentService } from 'src/app/services/otherPayment.service';

@Component({
  selector: 'app-other-payment',
  templateUrl: './other-payment.component.html',
  styleUrls: ['./other-payment.component.css']
})
export class OtherPaymentComponent {
  success: string = "Thanh toán không thành công";
  text: string = "Vui lòng kiểm tra lại!";

  private routeSubscription: Subscription;

  constructor(private otherPaymentService: OtherPaymentService, private route: ActivatedRoute, private router: Router) {
    this.routeSubscription = this.route.queryParams.subscribe(params => {
      // if (params && Object.keys(params).length > 0) {
      //   this.router.navigate([], { queryParams: {} });
      //   this.callback(params);
      // }
      this.callback(params);
    });
  }

  ngOnDestroy() {
    if (this.routeSubscription) {
      this.routeSubscription.unsubscribe();
    }
  }

  callback(params: any) {
    this.otherPaymentService.callBack(params).subscribe(res => {
      if(res.success){
        this.success = "Thanh toán chuyển khoản thành công đơn hàng " + res.orderId;
        this.text = "Cảm ơn bạn đã sử dụng dịch vụ!";
      }
    });
  }
}
