import { Component, ElementRef, ViewChild } from '@angular/core';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { AngularEditorConfig } from '@kolkov/angular-editor';
import { LienHe } from 'src/app/models/contact.model';
import { ContactService } from 'src/app/services/contact.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-manage-contact',
  templateUrl: './manage-contact.component.html',
  styleUrls: ['./manage-contact.component.css']
})
export class ManageContactComponent {
  DataContact: LienHe = {
    tieuDe: '',
    googleMap: '',
    noiDung: ''
  };
  TieuDe: string = '';
  GoogleMap: string = '';
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

  constructor(private contactService:ContactService, private sanitizer: DomSanitizer) { }

  ngOnInit(){
    this.getDataContact();
  }

  getSafeMapUrl(url: string): SafeResourceUrl {
    return this.sanitizer.bypassSecurityTrustResourceUrl(url);
  }

  getDataContact() {
    this.contactService.getDataAdmin().subscribe(res => {
      this.DataContact = res.data;
      this.TieuDe = res.data.tieuDe;
      this.GoogleMap = res.data.googleMap;
      this.NoiDung = res.data.noiDung;
    });
  }

  //thoát
  cancel() {
    this.getDataContact();
  }
  //Sửa
  update() {
    if (!this.TieuDe || !this.GoogleMap || !this.NoiDung) {
      Swal.fire({
        title: 'Thông báo',
        text: 'Vui lòng nhập đầy đủ thông tin (*)',
        icon: 'warning'
      });
      return;
    }
    // Tạo một đối tượng từ dữ liệu được chọn
    const LienHe: any = {
      TieuDe: this.TieuDe,
      GoogleMap: this.GoogleMap,
      NoiDung: this.NoiDung
    }
    // Gọi phương thức sửa từ service
    this.contactService.update(LienHe).subscribe(res => {
      Swal.fire({
        title: 'Thành công',
        text: 'Cập nhật liên hệ thành công!',
        icon: 'success'
      }).then(() => {
          this.getDataContact();

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
