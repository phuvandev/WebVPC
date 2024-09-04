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
export class BlogService {
  private apiUrl = `${API_BASE_URL}/TinTuc`;

  constructor(private http: HttpClient) {}

  getAllClient(obj: object): Observable<any>{
    return this.http.post(`${this.apiUrl}/get-all-client`, obj);
  }
  getOne(id:number): Observable<any>{
    return this.http.get(`${this.apiUrl}/get-one/${id}`);
  }
  getRandom(maTT: number, soLuong: number): Observable<any>{
    return this.http.get(`${this.apiUrl}/get-random?maTT=${maTT}&soLuong=${soLuong}`);
  }

  
  getAllAdmin(obj: object): Observable<any>{
    return this.http.post(`${this.apiUrl}/get-all-admin`, obj, { headers });
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