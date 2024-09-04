import { Component } from '@angular/core';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { Router } from '@angular/router';
import { LienHe } from 'src/app/models/contact.model';
import { ContactService } from 'src/app/services/contact.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-contact',
  templateUrl: './contact.component.html',
  styleUrls: ['./contact.component.css']
})
export class ContactComponent {
  DataContact: LienHe = {
    tieuDe: '',
    googleMap: '',
    noiDung: ''
  };

  constructor(private contactService:ContactService, private sanitizer: DomSanitizer, private router:Router) { }

  ngOnInit(){
    this.getDataContact();
  }

  getSafeMapUrl(url: string): SafeResourceUrl {
    return this.sanitizer.bypassSecurityTrustResourceUrl(url);
  }

  getDataContact() {
    this.contactService.getDataClient().subscribe(res => {
      if(res.data == null) {
        Swal.fire({
          icon: 'error',
          title: 'Lỗi',
          text: 'Trang hiện đang bảo trì!',
          timer: 2000
        }).then(() => {
          this.router.navigate(['/']);
        });
      }
      else {
        this.DataContact = res.data;
      }
    });
  }
}
