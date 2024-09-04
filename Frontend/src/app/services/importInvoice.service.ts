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
export class ImportInvoiceService {
  private apiUrl = `${API_BASE_URL}/HoaDonNhap`;

  constructor(private http: HttpClient) {}

  getAllAdmin(obj: object): Observable<any>{
    return this.http.post(`${this.apiUrl}/get-all-admin`, obj, { headers });
  }
  create(obj: object): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/create`, obj, { headers });
  }
  
  getByImportInvoice(id: number): Observable<any>{
    return this.http.get(`${this.apiUrl}/get-by-importInvoice/${id}`, { headers });
  }
}