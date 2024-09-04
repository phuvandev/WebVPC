import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ManageBlogComponent } from './manage-blog.component';

describe('ManageBlogComponent', () => {
  let component: ManageBlogComponent;
  let fixture: ComponentFixture<ManageBlogComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ManageBlogComponent]
    });
    fixture = TestBed.createComponent(ManageBlogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
