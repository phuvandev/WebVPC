import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { API_BASE_URL } from './api.service';

const _user = JSON.parse(localStorage.getItem('user') || '{}');
const headers = new HttpHeaders({
  'Authorization': 'Bearer ' + _user.token
});

@Injectable({
  providedIn: 'root',
})
export class ProductService {
  private apiUrl = `${API_BASE_URL}/SanPham`;

  constructor(private http: HttpClient) {}

  getNew(soLuong: number): Observable<any>{
    return this.http.get(`${this.apiUrl}/get-new/${soLuong}`);
  }
  getHot(soLuong: number): Observable<any>{
    return this.http.get(`${this.apiUrl}/get-hot/${soLuong}`);
  }
  getSale(soLuong: number): Observable<any>{
    return this.http.get(`${this.apiUrl}/get-sale/${soLuong}`);
  }
  
  getOne(id:number): Observable<any>{
    return this.http.get(`${this.apiUrl}/get-one/` + id);
  }
  getSameCategory(maDSP: number, maSP: number): Observable<any> {
    return this.http.get(`${this.apiUrl}/get-same-category?maDSP=${maDSP}&maSP=${maSP}`);
  }
  search(obj: object): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/search`, obj);
  }

  getByCategory(obj: object): Observable<any>{
    return this.http.post(`${this.apiUrl}/get-by-dsp`, obj);
  }


  getAllAdmin(obj: object): Observable<any>{
    return this.http.post(`${this.apiUrl}/get-all-admin`, obj, { headers });
  }
  getOneAdmin(id:number): Observable<any>{
    return this.http.get(`${this.apiUrl}/get-one-admin/${id}`, { headers });
  }
  getWithoutPrice(obj: any): Observable<any>{
    return this.http.post(`${this.apiUrl}/get-without-price`, obj, { headers });
  }
  create(obj: object): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/create`, obj, { headers });
  }
  update(obj: object): Observable<any> {
    return this.http.put<any>(`${this.apiUrl}/update`, obj, { headers });
  }
  delete(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/delete/${id}`, { headers });
  }
}