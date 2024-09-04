import { Component } from '@angular/core';
import { LoadCSSService } from 'src/app/services/loadCSS.service';
import { LoadJSService } from 'src/app/services/loadJS.service';

@Component({
  selector: 'app-client-layout',
  templateUrl: './client-layout.component.html',
  styleUrls: ['./client-layout.component.css']
})
export class ClientLayoutComponent {
  constructor(private loadCSSService: LoadCSSService, private loadJSService: LoadJSService) {}

  ngOnInit() {
    this.loadCSS();
    this.loadJS();
  }

  ngOnDestroy() {
    window.location.reload();
  }
  
  private async loadCSS(): Promise<void>{
    await this.loadCSSService.loadCSS('/assets/client/css/bundle.css');
    await this.loadCSSService.loadCSS('/assets/client/css/plugins.css');
  }

  private async loadJS(): Promise<void> {
    await this.loadJSService.loadScript('/assets/client/js/jquery-1.12.4.min.js');
    await this.loadJSService.loadScript('/assets/client/js/bootstrap.min.js');
    await this.loadJSService.loadScript('/assets/client/js/plugins.js');
    await this.loadJSService.loadScript('/assets/client/js/main.js');
  }
}
