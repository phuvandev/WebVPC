import { Component } from '@angular/core';
import { LoadCSSService } from 'src/app/services/loadCSS.service';
import { LoadJSService } from 'src/app/services/loadJS.service';

@Component({
  selector: 'app-admin-layout',
  templateUrl: './admin-layout.component.html',
  styleUrls: ['./admin-layout.component.css']
})
export class AdminLayoutComponent {
  
  constructor(private loadCSSService: LoadCSSService, private loadJSService: LoadJSService) {}

  ngOnInit() {
    this.loadCSS();
    this.loadJS();
  }

  ngOnDestroy() {
    window.location.reload();
  }

  private async loadCSS(): Promise<void>{
    await this.loadCSSService.loadCSS('/assets/admin/css/bootstrap.min.css');
    await this.loadCSSService.loadCSS('/assets/admin/css/font-awesome.min.css');
    await this.loadCSSService.loadCSS('/assets/admin/css/style.css');
    await this.loadCSSService.loadCSS('/assets/admin/css/components.css');
  }

  private async loadJS(): Promise<void> {
    await this.loadJSService.loadScript('/assets/admin/js/app.min.js');
    await this.loadJSService.loadScript('/assets/admin/js/scripts.js');
  }
}
