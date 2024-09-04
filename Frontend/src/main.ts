import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { AppModule } from './app/app.module';
import { SettingService } from './app/services/setting.service';


platformBrowserDynamic().bootstrapModule(AppModule)
  .then(platformRef => {
    const settingService = platformRef.injector.get(SettingService);
    settingService.getBySign("FAVICON").subscribe(res => {
      const icon = "data:image/jpg;base64," + res.data.anh;
      const favicon = document.getElementById('favicon') as HTMLLinkElement;
      if (favicon) {
        favicon.href = icon;
      }
    });
  })
  .catch(err => console.error(err));
