import { Component, ElementRef, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { SanPham } from 'src/app/models/product.model';
import { CartService } from 'src/app/services/cart.service';
import { ProductService } from 'src/app/services/product.service';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent {
  key: string = '';
  ListResult: SanPham[] = [];
  p: number = 1;
  pageSize: number = 12;
  totalItems: number = 0;

  @ViewChild('scroll') scroll!: ElementRef;

  constructor(private activatedRoute:ActivatedRoute, private productService:ProductService, private cartService:CartService){}

  ngOnInit(){
    this.getBySearch(this.p);
  }

  // Lấy sản phẩm tìm kiếm
  getBySearch(p: number) {
    this.activatedRoute.queryParams.subscribe((params) => {
      this.key = params['name'];

      const obj = {
        page: p,
        pageSize: this.pageSize,
        tenSP: this.key || ''
      };
      this.productService.search(obj).subscribe((res) => {
        this.ListResult = res.data;
        this.totalItems = res.totalItems;
        this.p = p;
        setTimeout(() => {
          if (this.scroll && this.scroll.nativeElement) {
            this.scroll.nativeElement.scrollIntoView({ behavior: 'smooth' });
          }
        }, 0);
      });
    });
  }

  //Thêm vào giỏ hàng
  addToCart(MaSP: number) {
    this.cartService.addToCart(MaSP, 1);
  }
}
