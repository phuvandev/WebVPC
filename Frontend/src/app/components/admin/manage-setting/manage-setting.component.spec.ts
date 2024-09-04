import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ManageSettingComponent } from './manage-setting.component';

describe('ManageSettingComponent', () => {
  let component: ManageSettingComponent;
  let fixture: ComponentFixture<ManageSettingComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ManageSettingComponent]
    });
    fixture = TestBed.createComponent(ManageSettingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
