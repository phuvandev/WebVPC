import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ManageSupplierComponent } from './manage-supplier.component';

describe('ManageSupplierComponent', () => {
  let component: ManageSupplierComponent;
  let fixture: ComponentFixture<ManageSupplierComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ManageSupplierComponent]
    });
    fixture = TestBed.createComponent(ManageSupplierComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
