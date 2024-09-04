import { Component, ElementRef, ViewChild } from '@angular/core';
import { AngularEditorConfig } from '@kolkov/angular-editor';
import { GioiThieu } from 'src/app/models/about.model';
import { AboutService } from 'src/app/services/about.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-about',
  templateUrl: './manage-about.component.html',
  styleUrls: ['./manage-about.component.css']
})
export class ManageAboutComponent {
  DataAbout: GioiThieu = {
    tieuDe: '',
    noiDung: ''
  };
  TieuDe: string = '';
  NoiDung: string = '';

  @ViewChild('modalUpdate') modalUpdate!: ElementRef;

  editorConfig: AngularEditorConfig = {
    editable: true,
    spellcheck: true,
    height: '15rem',
    minHeight: '5rem',
    placeholder: 'Nhập nội dung..',
    translate: 'no',
    defaultParagraphSeparator: 'p',
    defaultFontName: 'Arial'
  };

  constructor(private aboutService:AboutService) { }

  ngOnInit(){
    this.getDataAbout();
  }

  getDataAbout() {
    this.aboutService.getDataAdmin().subscribe(res => {
      this.DataAbout = res.data;
      this.TieuDe = res.data.tieuDe;
      this.NoiDung = res.data.noiDung;
    });
  }

  //thoát
  cancel() {
    this.getDataAbout();
  }
  //Sửa
  update() {
    if (!this.TieuDe || !this.NoiDung) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin (*)',
        icon: 'warning'
      });
      return;
    }
    // Tạo một đối tượng từ dữ liệu được chọn
    const GioiThieu: any = {
      TieuDe: this.TieuDe,
      NoiDung: this.NoiDung
    }
    // Gọi phương thức sửa từ service
    this.aboutService.update(GioiThieu).subscribe(res => {
      Swal.fire({
        title: 'Thành công',
        text: 'Cập nhật giới thiệu thành công!',
        icon: 'success'
      }).then(() => {
          this.getDataAbout();

          // Đóng modal khi tạo thành công
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
