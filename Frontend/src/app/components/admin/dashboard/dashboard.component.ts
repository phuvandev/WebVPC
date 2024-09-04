import { Component } from '@angular/core';
import { Chart } from 'chart.js/auto';
import { ThongKe, ThongKeSoLuong } from 'src/app/models/dashboard.model';
import { DashboardService } from 'src/app/services/dashboard.service';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent {
  Revenue12Month: ThongKe[] = [];
  HotCategory: ThongKe[] = [];
  Revenue5Year: ThongKe[] = [];
  Quantity:ThongKeSoLuong = { 
    soLuongSP: 0,
    soLuongKH: 0,
    soLuongDHDaHoanThanh: 0,
    soLuongDHChuaXacThuc: 0,
    doanhSo: 0,
    namHienTai: 0
  };

  barChart: any;
  pieChart: any;
  doughnutChart: any;

  constructor(private dashboardService:DashboardService){}

  ngOnInit(): void{
    this.getRevenue12Month();
    this.getHotCategory();
    this.getRevenue5Year();
    this.getQuantity();
  }
  ngOnDestroy(): void {
    if (this.barChart) {
      this.barChart.destroy();
    }
    if (this.pieChart) {
      this.pieChart.destroy();
    }
    if (this.doughnutChart) {
      this.doughnutChart.destroy();
    }
  }

  getQuantity() {
    this.dashboardService.quantity().subscribe(res => {
      this.Quantity = res.data;
    });
  }

  getRevenue12Month(){
    this.dashboardService.revenue12Month().subscribe(res => {
      this.Revenue12Month = res.data;
      const thang_nam = this.Revenue12Month.map(item => item.thangNam);
      const doanhthu = this.Revenue12Month.map(item => item.doanhThu);

      const data = {
        labels: thang_nam,
        datasets: [{
          label: 'Doanh thu',
          data: doanhthu,
          fill: false,
          tension: 0.1,
          backgroundColor: '#2971F5'
        }]
      };
      this.barChart = new Chart("barChart", {
        type: 'bar',
        data: data
      })
    });
  }

  getRevenue5Year(){
    this.dashboardService.revenue5Year().subscribe(res => {
      this.Revenue5Year = res.data;
      const nam = this.Revenue5Year.map(item => item.nam);
      const doanhthunam = this.Revenue5Year.map(item => item.doanhThuNam);
      const slsanphambanra = this.Revenue5Year.map(item => item.slSanPhamBanRa);
  
      const data = {
        labels: nam,
        datasets: [{
          label: 'Doanh thu',
          data: doanhthunam,
          backgroundColor: [
            '#2971F5', //blue
            'rgb(255, 205, 86)', //yellow
            '#1ABB9C', //green
            'rgb(255, 99, 132)', //pink
            'tomato'
          ],
          hoverOffset: 4
        },
        {
          label: 'Số lượng sản phẩm bán ra',
          data: slsanphambanra,
          backgroundColor: [
            '#2971F5', //blue
            'rgb(255, 205, 86)', //yellow
            '#1ABB9C', //green
            'rgb(255, 99, 132)', //pink
            '#50C1CF',
            'tomato'
          ],
          hoverOffset: 4
        }]
      };
      this.pieChart = new Chart("pieChart", {
        type: 'pie',
        data: data,
      })
    });
  }  

  getHotCategory(){
    this.dashboardService.hotCategory().subscribe(res => {
      this.HotCategory = res.data;
      const name = this.HotCategory.map(item => item.tenDSP);
      const quantity = this.HotCategory.map(item => item.soLuongSanPhamBanRa);

      const data = {
        labels: name,
        datasets: [{
          label: 'Sản phẩm bán ra',
          data: quantity,
          backgroundColor: [
            '#2971F5', //blue
            '#34495E', //black
            '#9B59B6', //purple
            'rgb(255, 205, 86)', //yellow
            '#1ABB9C', //green
            'rgb(255, 99, 132)', //pink
            '#50C1CF',
            'tomato'
          ],
          hoverOffset: 4
        }]
      };
      this.doughnutChart = new Chart("doughnutChart", {
        type: 'doughnut',
        data: data,
      })
    });
  }
  
}
