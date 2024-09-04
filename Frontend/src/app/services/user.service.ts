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
export class UserService {
  private apiUrl = `${API_BASE_URL}/NguoiDung`;

  constructor(private http: HttpClient) {}
  
  getAllStaff(obj: object): Observable<any>{
    return this.http.post(`${this.apiUrl}/get-all-staff`, obj, { headers });
  }

  getAllCustomer(obj: object): Observable<any>{
    return this.http.post(`${this.apiUrl}/get-all-customer`, obj, { headers });
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