import { Component, ElementRef, ViewChild } from '@angular/core';
import { AngularEditorConfig } from '@kolkov/angular-editor';
import { DongSanPham } from 'src/app/models/category.model';
import { SanPham } from 'src/app/models/product.model';
import { CategoryService } from 'src/app/services/category.service';
import { ProductService } from 'src/app/services/product.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-product',
  templateUrl: './manage-product.component.html',
  styleUrls: ['./manage-product.component.css']
})
export class ManageProductComponent {
  ListProduct: SanPham[] = [];
  ListCategory: DongSanPham[] = [];

  p: number = 1;
  pageSize: number = 10;
  totalItems: number = 0;

  MaSP:any;
  TenSP: string = '';
  AnhDaiDien: any;
  SoLuong: any;
  KichThuoc: string = '';
  TrongLuong: string = '';
  MatKinh: string = '';
  ChatLieuDay: string = '';
  ChongNuoc: string = '';
  LoaiMay: string = '';
  MoTa: string = '';
  NgayTao: string = '';
  TrangThai = '1';
  MaDSP:any;
  TenDSP: string = '';

  GiaBan: any;
  PhanTramGiamGia: any;
  GiaSauGiam: any;

  //Tìm kiếm
  search: string = '';

  previewImageUrl: string | ArrayBuffer | null = null;

  @ViewChild('scroll') scroll!: ElementRef;

  //Mở/đóng modal khi chưa selectedRow
  openModal: boolean = false;
  @ViewChild('modalCreate') modalCreate!: ElementRef;
  @ViewChild('modalDetail') modalDetail!: ElementRef;
  @ViewChild('modalUpdate') modalUpdate!: ElementRef;
  @ViewChild('fileInputC') fileInputC!: ElementRef; 
  @ViewChild('fileInputU') fileInputU!: ElementRef; 

  editorConfig: AngularEditorConfig = {
    editable: true,
    spellcheck: true,
    height: '15rem',
    minHeight: '5rem',
    placeholder: 'Nhập mô tả..',
    translate: 'no',
    defaultParagraphSeparator: 'p',
    defaultFontName: 'Arial'
  };
  
  constructor(private productService:ProductService, private categoryService:CategoryService) { }

  ngOnInit(){
    this.getListProduct(this.p);
    this.getListCategory();
  }

  getListProduct(p: number) {
    const obj = {
      page: p,
      pageSize: this.pageSize,
      tenSP: this.search
    }
    this.productService.getAllAdmin(obj).subscribe(res => {
      this.ListProduct = res.data;
      this.totalItems = res.totalItems;
      this.p = p;
      setTimeout(() => {
        if (this.scroll && this.scroll.nativeElement) {
          this.scroll.nativeElement.scrollIntoView({ behavior: 'smooth' });
        }
      }, 0);
    });
  }
  getListCategory() {
    this.categoryService.getAllClient().subscribe(res => {
      this.ListCategory = res.data;
    });
  }
  // Xử lý khi ấn vào dòng
  selectedRow: SanPham | null = null;
  onRowClick(sanpham: SanPham) {
    this.selectedRow = sanpham;
    this.MaSP = this.selectedRow.maSP;
    this.TenSP = this.selectedRow.tenSP;
    this.AnhDaiDien = this.selectedRow.anhDaiDien;
    this.SoLuong = this.selectedRow.soLuong;
    this.KichThuoc = this.selectedRow.kichThuoc;
    this.TrongLuong = this.selectedRow.trongLuong;
    this.MatKinh = this.selectedRow.matKinh;
    this.ChatLieuDay = this.selectedRow.chatLieuDay;
    this.ChongNuoc = this.selectedRow.chongNuoc;
    this.LoaiMay = this.selectedRow.loaiMay;
    this.MoTa = this.selectedRow.moTa;
    this.NgayTao = this.selectedRow.ngayTao;
    this.TrangThai = this.selectedRow.trangThai.toString();
    this.MaDSP = this.selectedRow.maDSP;
    this.TenDSP = this.selectedRow.tenDSP;

    this.GiaBan = this.selectedRow.giaBan;
    this.PhanTramGiamGia = this.selectedRow.phanTramGiamGia;
    this.GiaSauGiam = this.selectedRow.giaSauGiam;
  }

  //mở form tạo mới
  showCreate(){
    this.TenSP = '';
    this.AnhDaiDien = '';
    this.SoLuong = '';
    this.KichThuoc = '';
    this.TrongLuong = '';
    this.MatKinh = '';
    this.ChatLieuDay = '';
    this.ChongNuoc = '';
    this.LoaiMay = '';
    this.MoTa = '';
    this.TrangThai = '0';
    this.MaDSP = '';
    this.selectedRow = null;
  }
  //mở form chi tiết
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

  //mở form sửa
  showUpdate() {
    if (!this.selectedRow) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng chọn một dòng để sửa!',
        icon: 'warning'
      });
      this.openModal = false;
    }
    else {
      this.openModal = true;
    }
  }

  //mở form xóa
  showDelete() {
    if (!this.selectedRow) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng chọn một dòng để xóa!',
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
    this.previewImageUrl = null;
    // Đặt lại giá trị của input file
    if (this.fileInputC || this.fileInputU) {
      this.fileInputC.nativeElement.value = '';
      this.fileInputU.nativeElement.value = '';
    }
  }

  // Xử lý khi người dùng chọn một tệp ảnh
  onFileChange(event: any) {
    const fileList: FileList = event.target.files;// Lấy danh sách các tệp được chọn từ sự kiện change
    if (fileList.length > 0) {
      this.AnhDaiDien = fileList[0];
      const reader = new FileReader(); // Tạo một đối tượng FileReader để đọc dữ liệu của tệp
      reader.onload = () => {
        // Gán URL dữ liệu của ảnh vào biến previewImageUrl
        this.previewImageUrl = reader.result;
      };
      // Đọc tệp ảnh dưới dạng URL dữ liệu (data URL)
      reader.readAsDataURL(this.AnhDaiDien);
    }
  }

  //Thêm
  create() {
    if (!this.TenSP || !this.AnhDaiDien || !this.KichThuoc || !this.TrongLuong || !this.MatKinh || !this.ChatLieuDay || !this.ChongNuoc || !this.LoaiMay || !this.MoTa || !this.MaDSP || !this.TrangThai) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin (*)',
        icon: 'warning'
      });
      return;
    }

    const formData = new FormData();
    formData.append('tenSP', this.TenSP);
    formData.append('File', this.AnhDaiDien!);
    formData.append('kichThuoc', this.KichThuoc);
    formData.append('trongLuong', this.TrongLuong);
    formData.append('matKinh', this.MatKinh);
    formData.append('chatLieuDay', this.ChatLieuDay);
    formData.append('chongNuoc', this.ChongNuoc);
    formData.append('loaiMay', this.LoaiMay);
    formData.append('moTa', this.MoTa);
    formData.append('trangThai', this.TrangThai);
    formData.append('maDSP', this.MaDSP);
  
    this.productService.create(formData).subscribe(res => {
      Swal.fire({
        title: 'Thành công',
        text: 'Tạo sản phẩm thành công!',
        icon: 'success'
      }).then(() => {
          this.getListProduct(this.p); //refresh

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
  //Sửa
  update() {
    if (this.selectedRow) {
      if (!this.TenSP || !this.AnhDaiDien || !this.KichThuoc || !this.TrongLuong || !this.MatKinh || !this.ChatLieuDay || !this.ChongNuoc || !this.LoaiMay || !this.MoTa || !this.MaDSP) {
        Swal.fire({
          title: 'Thông báo',
          text: 'Vui lòng nhập đầy đủ thông tin (*)',
          icon: 'warning'
        });
        return;
      }
      
      const formData = new FormData();
      formData.append('maSP', this.MaSP);
      formData.append('tenSP', this.TenSP);
      formData.append('File', this.AnhDaiDien!);
      formData.append('kichThuoc', this.KichThuoc);
      formData.append('trongLuong', this.TrongLuong);
      formData.append('matKinh', this.MatKinh);
      formData.append('chatLieuDay', this.ChatLieuDay);
      formData.append('chongNuoc', this.ChongNuoc);
      formData.append('loaiMay', this.LoaiMay);
      formData.append('moTa', this.MoTa);
      formData.append('trangThai', this.TrangThai);
      formData.append('maDSP', this.MaDSP);
      
      // Gọi phương thức sửa từ service
      this.productService.update(formData).subscribe(res => {
        Swal.fire({
          title: 'Thành công',
          text: 'Cập nhật sản phẩm thành công!',
          icon: 'success'
        }).then(() => {
          this.selectedRow = null;
          this.getListProduct(this.p);
          
          // Đóng modal khi sửa thành công
          const modalUpdate = this.modalUpdate.nativeElement;
          modalUpdate.classList.remove('show');
          modalUpdate.style.display = 'none';
          document.body.classList.remove('modal-open');
          const modalBackdrop = document.getElementsByClassName('modal-backdrop');
          for (let i = 0; i < modalBackdrop.length; i++) {
            modalBackdrop[i].remove();
          }
        });
      });
    }
  }
  //Xóa
  delete() {
    if (this.selectedRow) {
      const id = this.selectedRow.maSP;
      Swal.fire({
        title: 'Thông báo',
        text: 'Bạn có chắc chắn muốn xóa thông tin sản phẩm này?',
        icon: 'warning',
        showCancelButton: true,
        cancelButtonText: 'Hủy'
      }).then((result) => {
        if (result.isConfirmed) {
          this.productService.delete(id).subscribe(res => {
            Swal.fire({
              title: 'Thông báo',
              text: 'Xóa sản phẩm thành công!',
              icon: 'success',
            }).then(() => {
              this.selectedRow = null;
              this.getListProduct(this.p);
            });
          }, error => {
            Swal.fire({
              icon: 'error',
              title: 'Lỗi',
              text: "Không thể xoá sản phẩm này!"
            }).then(() => {
              this.selectedRow = null;
              this.getListProduct(this.p);
            });
          });
        } 
        else if (result.dismiss === Swal.DismissReason.cancel) {
          this.selectedRow = null;
          this.getListProduct(this.p);
        }
      });
    }
  }
}
