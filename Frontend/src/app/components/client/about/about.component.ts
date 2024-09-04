import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { GioiThieu } from 'src/app/models/about.model';
import { AboutService } from 'src/app/services/about.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-about',
  templateUrl: './about.component.html',
  styleUrls: ['./about.component.css']
})
export class AboutComponent {
  DataAbout: GioiThieu = {
    tieuDe: '',
    noiDung: ''
  };
  constructor(private aboutService:AboutService, private router:Router) { }

  ngOnInit(){
    this.getDataAbout();
  }
  
  getDataAbout() {
    this.aboutService.getDataClient().subscribe(res => {
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
        this.DataAbout = res.data;
      }
    });
  }
}
