import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OtherPaymentComponent } from './other-payment.component';

describe('OtherPaymentComponent', () => {
  let component: OtherPaymentComponent;
  let fixture: ComponentFixture<OtherPaymentComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [OtherPaymentComponent]
    });
    fixture = TestBed.createComponent(OtherPaymentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
