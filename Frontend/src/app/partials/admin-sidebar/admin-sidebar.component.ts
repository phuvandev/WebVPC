import { Component } from '@angular/core';
import { AuthenticateService } from 'src/app/services/authenticate.service';
import { SettingService } from 'src/app/services/setting.service';

@Component({
  selector: 'app-admin-sidebar',
  templateUrl: './admin-sidebar.component.html',
  styleUrls: ['./admin-sidebar.component.css']
})
export class AdminSidebarComponent {
  FaviconWebsite: string = '';
  
  user: any;

  constructor(private authenticateService: AuthenticateService, private settingService:SettingService) {}

  ngOnInit() {
    this.getDataWebsite();
    this.user = this.authenticateService.checkLogin();
  }

  logout() {
    this.authenticateService.logout();
  }

  getDataWebsite() {
    this.settingService.getBySign('FAVICON').subscribe(res => { 
      this.FaviconWebsite = res.data.anh;
    });
  }
}
