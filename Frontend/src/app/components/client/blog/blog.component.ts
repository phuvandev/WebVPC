import { Component, ElementRef, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { TinTuc } from 'src/app/models/blog.model';
import { BlogService } from 'src/app/services/blog.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-blog',
  templateUrl: './blog.component.html',
  styleUrls: ['./blog.component.css']
})
export class BlogComponent {
  ListBlog : TinTuc[] = [];
  p: number = 1;
  pageSize: number = 6;
  totalItems: number = 0;

  @ViewChild('scroll') scroll!: ElementRef;

  constructor(private blogService:BlogService, private router:Router) { }

  ngOnInit(){
    this.getListBlog(this.p);
  }
  
  limitText(text: string, maxLength: number): string {
    return text.length > maxLength ? text.slice(0, maxLength) + '...' : text;
  }
  
  getListBlog(p: number) {
    const obj = {
      page: p,
      pageSize: this.pageSize
    }
    this.blogService.getAllClient(obj).subscribe(res => {
      if(res.data[0] == null) {
        Swal.fire({
          icon: 'error',
          title: 'Lỗi',
          text: 'Trang hiện đang bảo trì!',
          timer: 2000
        }).then(() => {
          this.router.navigate(['/']);
        });
      }
      else {
        this.ListBlog = res.data;
        this.totalItems = res.totalItems;
        this.p = p;
        setTimeout(() => {
          if (this.scroll && this.scroll.nativeElement) {
            this.scroll.nativeElement.scrollIntoView({ behavior: 'smooth' });
          }
        }, 0);
      }
    });
  }
}
