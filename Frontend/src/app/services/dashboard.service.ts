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
export class DashboardService {
  private apiUrl = `${API_BASE_URL}/ThongKe`;

  constructor(private http: HttpClient) {}

  quantity(): Observable<any>{
    return this.http.get(`${this.apiUrl}/statistic-quantity`, { headers });
  }

  revenue12Month(): Observable<any>{
    return this.http.get(`${this.apiUrl}/statistic-revenue-12month`, { headers });
  }

  hotCategory(): Observable<any>{
    return this.http.get(`${this.apiUrl}/statistic-hot-category`, { headers });
  }

  revenue5Year(): Observable<any>{
    return this.http.get(`${this.apiUrl}/statistic-revenue-5year`, { headers });
  }
}