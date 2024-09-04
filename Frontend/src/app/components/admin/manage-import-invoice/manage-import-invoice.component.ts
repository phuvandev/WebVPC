import { Component, ElementRef, ViewChild } from '@angular/core';
import { CTHoaDonNhap, HoaDonNhap } from 'src/app/models/importInvoice.model';
import { SanPham } from 'src/app/models/product.model';
import { NhaCungCap } from 'src/app/models/supplier.model';
import { AuthenticateService } from 'src/app/services/authenticate.service';
import { ImportInvoiceService } from 'src/app/services/importInvoice.service';
import { ProductService } from 'src/app/services/product.service';
import { SupplierService } from 'src/app/services/supplier.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-import-invoice',
  templateUrl: './manage-import-invoice.component.html',
  styleUrls: ['./manage-import-invoice.component.css']
})
export class ManageImportInvoiceComponent {
  ListImportInvoice: HoaDonNhap[] = [];
  ListImportInvoiceDetail: CTHoaDonNhap[] = [];

  ListSupplierSearch: NhaCungCap[] = [];
  ListProductSearch: SanPham[] = [];

  p: number = 1;
  pageSize: number = 10;
  totalItems: number = 0;

  MaHDN: any;
  NgayNhap: string = '';
  TrangThai = 1;
  MaND: any;
  MaNCC: any;

  HoTen: string = '';
  TenNCC: string = '';
  TongTien: number = 0;

  //Tìm kiếm
  search: string = '';
  //Tìm kiếm trong ô select NCC
  search2: string = '';
  //Tìm kiếm trong ô select SP
  search3: string = '';

  user: any;

  @ViewChild('scroll') scroll!: ElementRef;
  
  //Mở/đóng modal khi chưa selectedRow
  openModal: boolean = false;
  @ViewChild('modalCreate') modalCreate!: ElementRef;
  @ViewChild('modalDetail') modalDetail!: ElementRef;

  newImportInvoiceDetail: { soLuong: number, giaNhap: number, maSP: any, tenSP: string, anhDaiDien: string } = { 
    soLuong: 0, 
    giaNhap: 0, 
    maSP: 0, 
    tenSP: '', 
    anhDaiDien: ''
  };
  ImportInvoiceDetail: { soLuong: number, giaNhap: number, maSP: any, tenSP: string, anhDaiDien: string } [] = [];

  constructor(private importInvoiceService:ImportInvoiceService, private supplierService:SupplierService, private productService:ProductService, private authenticateService:AuthenticateService) { }

  ngOnInit(){
    this.getListImportInvoice(this.p);
    this.user = this.authenticateService.checkLogin();

    this.getListSupplierSearch();
    this.getListProductSearch();
  }

  getListImportInvoice(p: number) {
    const obj = {
      page: p,
      pageSize: this.pageSize,
      tenNCC: this.search
    }
    this.importInvoiceService.getAllAdmin(obj).subscribe(res => {
      this.ListImportInvoice = res.data;
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
  selectedRow: HoaDonNhap | null = null;
  onRowClick(hoadonnhap: HoaDonNhap) {
    this.selectedRow = hoadonnhap;
    this.MaHDN = this.selectedRow.maHDN;
    this.NgayNhap = this.selectedRow.ngayNhap;
    this.TrangThai = this.selectedRow.trangThai;
    this.MaND = this.selectedRow.maND;
    this.MaNCC = this.selectedRow.maNCC;

    this.HoTen = this.selectedRow.hoTen;
    this.TenNCC = this.selectedRow.tenNCC;
    this.TongTien = this.selectedRow.tongTien;
    this.importInvoiceService.getByImportInvoice(this.selectedRow.maHDN).subscribe(res => {
      this.ListImportInvoiceDetail = res.data;
    });
  }

  //mở form tạo mới
  showCreate(){
    this.selectedRow = null;

    this.MaNCC = null;
    this.newImportInvoiceDetail.soLuong = 0;
    this.newImportInvoiceDetail.giaNhap = 0;
    this.newImportInvoiceDetail.maSP = null;
    this.ImportInvoiceDetail.splice(0, this.ImportInvoiceDetail.length);
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
  getListSupplierSearch() {
    const obj = {
      page: 1,
      pageSize: 10,
      tenNCC: this.search2
    }
    this.supplierService.getAllAdmin(obj).subscribe(res => {
      this.ListSupplierSearch = res.data;
    });
  }

  // Hàm được gọi khi có sự thay đổi trong trường tìm kiếm
  onSearchChange(event: any) {
    this.search2 = event.target.value;
    this.getListSupplierSearch(); 

    this.search3 = event.target.value;
    this.getListProductSearch(); 
  }

  getListProductSearch() {
    const obj = {
      page: 1,
      pageSize: 20,
      tenSP: this.search3
    }
    this.productService.getAllAdmin(obj).subscribe(res => {
      this.ListProductSearch = res.data;
    });
  }

  //Thêm chi tiết hóa đơn nhập
  createImportInvoiceDetail() {
    if (isNaN(this.newImportInvoiceDetail.soLuong) || isNaN(this.newImportInvoiceDetail.giaNhap)) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập số!',
        icon: 'warning'
      });
      return;
    }
  
    if (this.newImportInvoiceDetail.soLuong && this.newImportInvoiceDetail.giaNhap && this.newImportInvoiceDetail.maSP) {
      this.productService.getOneAdmin(this.newImportInvoiceDetail.maSP).subscribe(res => {
        console.log(res);

        this.ImportInvoiceDetail.push({ ...this.newImportInvoiceDetail, tenSP: res.data.tenSP, anhDaiDien: res.data.anhDaiDien });
        this.newImportInvoiceDetail = { soLuong: 0, giaNhap: 0, maSP: null, tenSP: '', anhDaiDien: ''};
      });
    } else {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin chi tiết hóa đơn nhập!',
        icon: 'warning'
      });
    }
  }
  //xóa thông số kỹ thuật khỏi mảng
  deleteImportInvoiceDetail(index: number): void {
    this.ImportInvoiceDetail.splice(index, 1);
  }

  //làm mới
  refresh() {
    this.MaNCC = null;
    this.newImportInvoiceDetail.soLuong = 0;
    this.newImportInvoiceDetail.giaNhap = 0;
    this.newImportInvoiceDetail.maSP = null;
  }

  //Thêm
  create() {
    if (!this.user.hoTen || !this.MaNCC) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin (*)',
        icon: 'warning'
      });
      return;
    }
    
    const HoaDonNhap: {
      maND: number,
      maNCC: number,
      listjson_chitiethoadonnhap: { soLuong: number, giaNhap: number, maSP: number }[];
    } = {
      //trái: postman >< phải: ngModel
      maND: this.user.maND,
      maNCC: this.MaNCC,
      listjson_chitiethoadonnhap: this.ImportInvoiceDetail
    };

    Swal.fire({
      title: 'Thông báo',
      text: 'Không thể hoàn tác! Bạn có chắc chắn muốn tạo hóa đơn nhập này?',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Xác nhận',
      cancelButtonText: 'Hủy'
    }).then((result) => {
      if (result.isConfirmed) {
        this.importInvoiceService.create(HoaDonNhap).subscribe(res => {
          Swal.fire({
            title: 'Thành công',
            text: 'Tạo hóa đơn nhập thành công!',
            icon: 'success'
          }).then(() => {
              this.getListImportInvoice(this.p); //refresh

              // Đóng modal khi tạo thành công
              const modalCreate = this.modalCreate.nativeElement;
              modalCreate.classList.remove('show');
              modalCreate.style.display = 'none';
              document.body.classList.remove('modal-open');
              const modalBackdrop = document.getElementsByClassName('modal-backdrop');
              for (let i = 0; i < modalBackdrop.length; i++) {
                modalBackdrop[i].remove();
              }
          });
        });
      }
    });
  }
}
