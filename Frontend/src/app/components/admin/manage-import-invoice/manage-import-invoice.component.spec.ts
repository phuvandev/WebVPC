import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ManageImportInvoiceComponent } from './manage-import-invoice.component';

describe('ManageImportInvoiceComponent', () => {
  let component: ManageImportInvoiceComponent;
  let fixture: ComponentFixture<ManageImportInvoiceComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ManageImportInvoiceComponent]
    });
    fixture = TestBed.createComponent(ManageImportInvoiceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
