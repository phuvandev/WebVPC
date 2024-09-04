import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';
import Swal from 'sweetalert2';
import { API_BASE_URL } from './api.service';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root',
})
export class AuthenticateService {
    private apiUrl = `${API_BASE_URL}/NguoiDung`;
    private currentUser: any;

    constructor(private http: HttpClient, private router:Router) {}

    //Đăng nhập
    login(nguoidung: object): Observable<any> {
        return this.http.post<any>(`${this.apiUrl}/login`, nguoidung).pipe(
            tap((user) => {
                return of('');
            }),
            catchError((error) => {
                return of(error.error);
            })
        );
    }

    //Đăng xuất
    logout() {
        localStorage.clear();
        Swal.fire({
            title: 'Đăng xuất thành công',
            text: 'Tạm biệt và hẹn gặp lại!',
            icon: 'success',
            showConfirmButton: false,
            timer: 1500,
            timerProgressBar: true,
            didOpen: () => {
                Swal.showLoading();
            }
        }).then(() => {
            this.router.navigate(['/']);
        });
    }

    checkLogin(): any{
        let jsondata = localStorage.getItem('user');
        if(jsondata){
            return JSON.parse(jsondata);
        }
        return  false;
    }

    getCurrentUser(): any {
        const storedUser = localStorage.getItem('user');
        this.currentUser = storedUser ? JSON.parse(storedUser) : null;
        return this.currentUser;
    }
    
    isAuthenticated(): boolean {
        const user = this.getCurrentUser();
        return !!user && !!user.token;
    }

    //Đăng ký
    register(obj: object): Observable<any> {
        return this.http.post<any>(`${this.apiUrl}/register`, obj);
    }
    //Kiểm tra đăng ký
    checkExist(obj: object): Observable<any> {
        return this.http.post<any>(`${this.apiUrl}/check-exist`, obj);
    }

    isTokenValid(): boolean {
        const user = this.getCurrentUser();
        if (user && user.token) {
            const loginTime = user.loginTime;
            //1 phút: 1 * 60 * 1000
            const tokenExpirationTime = loginTime + (12 * 60 * 60 * 1000); // 12 giờ: 12 * 60 * 60 * 1000
            const currentTime = new Date().getTime();
            if (currentTime > tokenExpirationTime) {
                this.logout();
                return false;
            }
            return true;
        }
        return false;
    }

}