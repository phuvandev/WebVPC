import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ManageSlideComponent } from './manage-slide.component';

describe('ManageSlideComponent', () => {
  let component: ManageSlideComponent;
  let fixture: ComponentFixture<ManageSlideComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ManageSlideComponent]
    });
    fixture = TestBed.createComponent(ManageSlideComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
