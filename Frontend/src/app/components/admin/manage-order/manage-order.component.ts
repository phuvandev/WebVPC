import { Component, ElementRef, ViewChild } from '@angular/core';
import { CTDonHang, DonHang } from 'src/app/models/order.model';
import { OrderService } from 'src/app/services/order.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-order',
  templateUrl: './manage-order.component.html',
  styleUrls: ['./manage-order.component.css']
})
export class ManageOrderComponent {
  ListOrder: DonHang[] = [];
  ListOrderDetail: CTDonHang[] = [];

  p: number = 1;
  pageSize: number = 20;
  totalItems: number = 0;

  MaDH: any;
  TenKH: string = '';
  Email: string = '';
  DiaChiGiaoHang: string = '';
  SDT: string = '';
  GhiChu: string = '';
  NgayDat: string = '';
  PhuongThucThanhToan: string = '';
  TrangThai = 1;
  MaND: any;
  TongTien: number = 0;

  //Tìm kiếm
  search: string = '';

  @ViewChild('scroll') scroll!: ElementRef;

  //Mở/đóng modal khi chưa selectedRow
  openModal: boolean = false;
  @ViewChild('modalDetail') modalDetail!: ElementRef;

  constructor(private orderService:OrderService) { }

  ngOnInit(){
    this.getListOrder(this.p);
  }

  getListOrder(p: number) {
    const obj = {
      page: p,
      pageSize: this.pageSize,
      tenKH: this.search
    }
    this.orderService.getAllAdmin(obj).subscribe(res => {
      this.ListOrder = res.data;
      this.totalItems = res.totalItems;
      this.p = p;
      setTimeout(() => {
        if (this.scroll && this.scroll.nativeElement) {
          this.scroll.nativeElement.scrollIntoView({ behavior: 'smooth' });
        }
      }, 0);
    });
  }

  // Xử lý khi ấn vào dòng
  selectedRow: DonHang | null = null;
  onRowClick(donhang: DonHang) {
    this.selectedRow = donhang;
    this.MaDH = this.selectedRow.maDH;
    this.TenKH = this.selectedRow.tenKH;
    this.Email = this.selectedRow.email;
    this.DiaChiGiaoHang = this.selectedRow.diaChiGiaoHang;
    this.SDT = this.selectedRow.sdt;
    this.GhiChu = this.selectedRow.ghiChu;
    this.NgayDat = this.selectedRow.ngayDat;
    this.PhuongThucThanhToan = this.selectedRow.phuongThucThanhToan;
    this.TrangThai = this.selectedRow.trangThai;
    this.MaND = this.selectedRow.maND;
    this.TongTien = this.selectedRow.tongTien;
    this.orderService.getByOrder(this.selectedRow.maDH).subscribe(res => {
      this.ListOrderDetail = res.data;
    });
  }

  //mở form sửa
  showDetail() {
    if (!this.selectedRow) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng chọn một dòng để xem chi tiết!',
        icon: 'warning'
      });
      this.openModal = false;
    }
    else {
      this.openModal = true;
    }
  }

  //thoát
  cancel() {
    this.selectedRow = null;
  }

  //Duyệt đơn
  check(action: string) {
    if (this.selectedRow) {
      let TrangThai: number;
      switch(action) {
        case 'cancel':
          TrangThai = 2;
          break;
        case 'confirm':
          TrangThai = 1;
          break;
        case 'ship':
          TrangThai = 4;
          break;
        case 'paymentSuccess':
          TrangThai = 5;
          break;
        default:
          // Nếu không phù hợp với bất kỳ hành động nào, không thực hiện gì cả
          return;
      }
      
      const DonHang: any = {
        maDH: this.MaDH,
        trangThai: TrangThai
      };

      Swal.fire({
        title: 'Thông báo',
        text: 'Không thể hoàn tác! Bạn có chắc chắn muốn tiếp tục?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Xác nhận',
        cancelButtonText: 'Hủy'
      }).then((result) => {
        if (result.isConfirmed) {
          this.orderService.check(DonHang).subscribe(res => {
            Swal.fire({
              title: 'Thông báo',
              text: 'Duyệt đơn hàng thành công!',
              icon: 'success',
              didClose: () => {
                this.selectedRow = null;
                this.getListOrder(this.p);
                
                // Đóng modal khi tạo thành công
                const modal = this.modalDetail.nativeElement;
                modal.classList.remove('show');
                modal.style.display = 'none';
                document.body.classList.remove('modal-open');
                const modalBackdrop = document.getElementsByClassName('modal-backdrop');
                for (let i = 0; i < modalBackdrop.length; i++) {
                  modalBackdrop[i].remove();
                }
              }
            });
          });
        } else if (result.dismiss === Swal.DismissReason.cancel) {
          this.selectedRow = null;
          this.getListOrder(this.p);

          // Đóng modal khi tạo thành công
          const modal = this.modalDetail.nativeElement;
          modal.classList.remove('show');
          modal.style.display = 'none';
          document.body.classList.remove('modal-open');
          const modalBackdrop = document.getElementsByClassName('modal-backdrop');
          for (let i = 0; i < modalBackdrop.length; i++) {
            modalBackdrop[i].remove();
          }
        }
      });
    }
  }

  downloadFile(data: Blob) {
    const blob = new Blob([data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'donhang_' + this.MaDH + '.xlsx';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    window.URL.revokeObjectURL(url);
  }
  
  exportToExcel() {
    if (!this.selectedRow) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng chọn một dòng để xuất dữ liệu!',
        icon: 'warning'
      });
    } 
    else {
      this.orderService.exportToExcel(this.MaDH).subscribe(res => {
        this.downloadFile(res);
        this.selectedRow = null;
      });
    }
  }
  
}
