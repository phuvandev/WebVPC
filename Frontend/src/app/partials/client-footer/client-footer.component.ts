import { Component } from '@angular/core';
import { SettingService } from 'src/app/services/setting.service';

@Component({
  selector: 'app-client-footer',
  templateUrl: './client-footer.component.html',
  styleUrls: ['./client-footer.component.css']
})
export class ClientFooterComponent {
  NameWebsite: string = '';
  AddressWebsite: string = '';
  EmailWebsite: string = '';
  PhoneWebsite: string = '';
  CopyrightWebsite: string = '';
  DomainWebsite: string = '';

  constructor(private settingService:SettingService) {}

  ngOnInit() {
    this.getDataWebsite();
  }

  getDataWebsite() {
    this.settingService.getBySign('NAME_WEB').subscribe(res => { 
      this.NameWebsite = res.data.moTa;
    });
    this.settingService.getBySign('ADDRESS').subscribe(res => { 
      this.AddressWebsite = res.data.moTa;
    });
    this.settingService.getBySign('EMAIL').subscribe(res => { 
      this.EmailWebsite = res.data.moTa;
    });
    this.settingService.getBySign('DOMAIN').subscribe(res => { 
      this.DomainWebsite = res.data.moTa;
    });
    this.settingService.getBySign('PHONE').subscribe(res => { 
      this.PhoneWebsite = res.data.moTa;
    });
    this.settingService.getBySign('COPYRIGHT').subscribe(res => { 
      this.CopyrightWebsite = res.data.moTa;
    });
  }
}
