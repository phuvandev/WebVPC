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
export class ContactService {
  private apiUrl = `${API_BASE_URL}/LienHe`;

  constructor(private http: HttpClient) {}

  getDataClient(): Observable<any>{
    return this.http.get(`${this.apiUrl}/get-data-client`);
  }

  getDataAdmin(): Observable<any>{
    return this.http.get(`${this.apiUrl}/get-data-admin`, { headers });
  }
  update(obj: object): Observable<any> {
    return this.http.put<any>(`${this.apiUrl}/update`, obj, { headers });
  }
}