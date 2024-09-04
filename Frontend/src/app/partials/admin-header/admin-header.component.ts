import { Component } from '@angular/core';
import { Setting } from 'src/app/models/setting.model';
import { AuthenticateService } from 'src/app/services/authenticate.service';
import { LoadCSSService } from 'src/app/services/loadCSS.service';
import { SettingService } from 'src/app/services/setting.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-admin-header',
  templateUrl: './admin-header.component.html',
  styleUrls: ['./admin-header.component.css']
})
export class AdminHeaderComponent {
  user:any;

  constructor(private authenticateService:AuthenticateService) {}

  ngOnInit(){
    this.user = this.authenticateService.checkLogin();
  }

  logout() {
    this.authenticateService.logout();
  }

}
