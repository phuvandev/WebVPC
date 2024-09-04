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
export class OrderService {
  private apiUrl = `${API_BASE_URL}/DonHang`;

  constructor(private http: HttpClient) {}

  create(obj: object): Observable<any>{
    return this.http.post(`${this.apiUrl}/create`, obj, { headers });
  }
  getOneNew(): Observable<any>{
    return this.http.get(`${this.apiUrl}/get-one-new`, { headers });
  }
  sendOrderEmail(obj: object): Observable<any>{
    return this.http.post(`${this.apiUrl}/send-order-email`, obj, { headers });
  }

  getAllAdmin(obj: object): Observable<any>{
    return this.http.post(`${this.apiUrl}/get-all-admin`, obj, { headers });
  }
  getByOrder(id: number): Observable<any>{
    return this.http.get(`${this.apiUrl}/get-by-order/${id}`, { headers });
  }
  check(obj: object): Observable<any> {
    return this.http.put<any>(`${this.apiUrl}/check`, obj, { headers });
  }

  getPurchaseHistory(obj: object): Observable<any>{
    return this.http.post(`${this.apiUrl}/get-purchase-history`, obj, { headers });
  }

  exportToExcel(id: number): Observable<Blob> {
    return this.http.get(`${this.apiUrl}/export-to-excel/` + id, { responseType: 'blob', headers: headers });
  }
}