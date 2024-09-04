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
export class OtherPaymentService {
  private apiUrl = `${API_BASE_URL}/VnPay`;

  constructor(private http: HttpClient) {}

  vnPay(obj: object): Observable<any>{
    return this.http.post(`${this.apiUrl}/vnpay`, obj, { headers });
  }

  callBack(data: any): Observable<any> {
    const queryString = Object.keys(data).map(key => key + '=' + encodeURIComponent(data[key])).join('&');
    return this.http.get<any>(`${this.apiUrl}/call-back?${queryString}`, { headers });
  }
}