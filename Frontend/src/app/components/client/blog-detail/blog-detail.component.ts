import { Component } from '@angular/core';
import { Title } from '@angular/platform-browser';
import { ActivatedRoute, Router } from '@angular/router';
import { TinTuc } from 'src/app/models/blog.model';
import { BlogService } from 'src/app/services/blog.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-blog-detail',
  templateUrl: './blog-detail.component.html',
  styleUrls: ['./blog-detail.component.css']
})
export class BlogDetailComponent {
  DataBlog: TinTuc = {
    maTT: 0,
    anhDaiDien: '',
    tieuDe: '',
    ngayDang: '',
    noiDung: '',
    trangThai: 0,
    maND: 0,
    hoTen: ''
  }
  ListRandom: TinTuc [] = [];
  SoLuong: number = 10;

  constructor(private blogService:BlogService, private route:ActivatedRoute, private title:Title, private router:Router) { }
  
  ngOnInit(){
    this.getOne();
    this.getRandom();
  }

  getOne() {
    this.route.params.subscribe(params => {
      // /chuyển đổi giá trị chuỗi thành số
      const id = +params['id'];
      this.blogService.getOne(id).subscribe(res => {
        if(res.success) {
          this.DataBlog = res.data;
          // Đặt tiêu đề của trang
          const pageTitle = `Tin tức - ${this.DataBlog?.tieuDe} - Văn Phú Casio`;
          this.title.setTitle(pageTitle);
        }
        else {
          Swal.fire({
            icon: 'error',
            title: 'Lỗi',
            text: res.message,
            timer: 2000
          }).then(() => {
            this.router.navigate(['/']);
          });
        }  
      });
    });
  }

  getRandom() {
    this.route.params.subscribe(params => {
      const id = +params['id'];
      this.blogService.getRandom(id, this.SoLuong).subscribe(res => {
        this.ListRandom = res.data;
      });
    });
  }
}
