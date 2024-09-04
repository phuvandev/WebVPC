import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ClientLayoutComponent } from './partials/client-layout/client-layout.component';
import { HomeComponent } from './components/client/home/home.component';
import { AboutComponent } from './components/client/about/about.component';
import { ContactComponent } from './components/client/contact/contact.component';
import { BlogComponent } from './components/client/blog/blog.component';
import { BlogDetailComponent } from './components/client/blog-detail/blog-detail.component';
import { CategoryComponent } from './components/client/category/category.component';
import { ProductComponent } from './components/client/product/product.component';
import { LoginComponent } from './components/client/login/login.component';
import { RegisterComponent } from './components/client/register/register.component';

import { Error404Component } from './components/error404/error404.component';
import { CartComponent } from './components/client/cart/cart.component';
import { AccountComponent } from './components/client/account/account.component';
import { CheckoutComponent } from './components/client/checkout/checkout.component';
import { OtherPaymentComponent } from './components/client/other-payment/other-payment.component';

import { AuthGuard } from './services/guard.service';
import { AdminLayoutComponent } from './partials/admin-layout/admin-layout.component';
import { DashboardComponent } from './components/admin/dashboard/dashboard.component';
import { ManageProductComponent } from './components/admin/manage-product/manage-product.component';
import { ManageMenuComponent } from './components/admin/manage-menu/manage-menu.component';
import { ManageSlideComponent } from './components/admin/manage-slide/manage-slide.component';
import { ManageBannerComponent } from './components/admin/manage-banner/manage-banner.component';
import { ManageAboutComponent } from './components/admin/manage-about/manage-about.component';
import { ManageBlogComponent } from './components/admin/manage-blog/manage-blog.component';
import { ManageContactComponent } from './components/admin/manage-contact/manage-contact.component';
import { ManageSettingComponent } from './components/admin/manage-setting/manage-setting.component';
import { ManageCategoryComponent } from './components/admin/manage-category/manage-category.component';
import { ManagePriceComponent } from './components/admin/manage-price/manage-price.component';
import { ManageStaffComponent } from './components/admin/manage-staff/manage-staff.component';
import { ManageCustomerComponent } from './components/admin/manage-customer/manage-customer.component';
import { ManageImportInvoiceComponent } from './components/admin/manage-import-invoice/manage-import-invoice.component';
import { ManageSupplierComponent } from './components/admin/manage-supplier/manage-supplier.component';
import { ManageOrderComponent } from './components/admin/manage-order/manage-order.component';
import { SearchComponent } from './components/client/search/search.component';
import { ProfileComponent } from './components/admin/profile/profile.component';
import { ManageRoleComponent } from './components/admin/manage-role/manage-role.component';
import { CartGuard } from './services/cartGuard.service';

const routes: Routes = [
  {
    path:'', component: ClientLayoutComponent,
    children:[
      {
        path: 'dang-nhap',
        component: LoginComponent,
        title: 'Đăng nhập - Văn Phú Casio'
      },
      {
        path: 'dang-ky',
        component: RegisterComponent,
        title: 'Đăng ký - Văn Phú Casio'
      },
      {
        path: '',
        component: HomeComponent,
        title: 'Trang chủ - Văn Phú Casio'
      },
      {
        path: 'gioi-thieu',
        component: AboutComponent,
        title: 'Giới thiệu - Văn Phú Casio'
      },
      {
        path: 'tin-tuc',
        component: BlogComponent,
        title: 'Tin tức - Văn Phú Casio'
      },
      {
        path: 'tin-tuc/:id',
        component: BlogDetailComponent
      },
      {
        path: 'lien-he',
        component: ContactComponent,
        title: 'Liên hệ - Văn Phú Casio'
      },
      {
        path: 'dong-san-pham/:id',
        component: CategoryComponent
      },
      {
        path: 'san-pham/:id',
        component: ProductComponent
      },
      {
        path: 'gio-hang',
        component: CartComponent
      },
      {
        path: 'thanh-toan',
        component: CheckoutComponent,
        canActivate : [AuthGuard, CartGuard],
        title: 'Thanh toán - Văn Phú Casio'
      },
      {
        path: 'thanh-toan-chuyen-khoan',
        component: OtherPaymentComponent,
        title: 'Thanh toán chuyển khoản - Văn Phú Casio'
      },
      {
        path: 'tai-khoan',
        component: AccountComponent,
        canActivate : [AuthGuard],
        title: 'Tài khoản - Văn Phú Casio'
      },
      {
        path: 'tim-kiem',
        component: SearchComponent,
        title: 'Tìm kiếm - Casio Văn Phú'
      }
    ]
  },
  {
    path:'admin', component: AdminLayoutComponent,
    canActivate: [AuthGuard],
    children:[
      {
        path: '',
        component: DashboardComponent,
        title: 'Quản trị hệ thống Văn Phú Casio'
      },
      {
        path: 'quan-ly-don-hang',
        component: ManageOrderComponent,
        title: 'Quản lý đơn hàng - Văn Phú Casio'
      },
      {
        path: 'quan-ly-menu',
        component: ManageMenuComponent,
        title: 'Quản lý menu - Văn Phú Casio'
      },
      {
        path: 'quan-ly-slide',
        component: ManageSlideComponent,
        title: 'Quản lý slide - Văn Phú Casio'
      },
      {
        path: 'quan-ly-banner',
        component: ManageBannerComponent,
        title: 'Quản lý banner - Văn Phú Casio'
      },
      {
        path: 'quan-ly-gioi-thieu',
        component: ManageAboutComponent,
        title: 'Quản lý giới thiệu - Văn Phú Casio'
      },
      {
        path: 'quan-ly-tin-tuc',
        component: ManageBlogComponent,
        title: 'Quản lý tin tức - Văn Phú Casio'
      },
      {
        path: 'quan-ly-lien-he',
        component: ManageContactComponent,
        title: 'Quản lý liên hệ - Văn Phú Casio'
      },
      {
        path: 'quan-ly-cai-dat',
        component: ManageSettingComponent,
        title: 'Quản lý cài đặt trang - Văn Phú Casio'
      },
      {
        path: 'quan-ly-dong-san-pham',
        component: ManageCategoryComponent,
        title: 'Quản lý dòng sản phẩm - Văn Phú Casio'
      },
      {
        path: 'quan-ly-san-pham',
        component: ManageProductComponent,
        title: 'Quản lý sản phẩm - Văn Phú Casio'
      },
      {
        path: 'quan-ly-gia-san-pham',
        component: ManagePriceComponent,
        title: 'Quản lý giá sản phẩm - Văn Phú Casio'
      },
      {
        path: 'quan-ly-nhan-vien',
        component: ManageStaffComponent,
        title: 'Quản lý nhân viên - Văn Phú Casio'
      },
      {
        path: 'quan-ly-khach-hang',
        component: ManageCustomerComponent,
        title: 'Quản lý khách hàng - Văn Phú Casio'
      },
      {
        path: 'quan-ly-hoa-don-nhap',
        component: ManageImportInvoiceComponent,
        title: 'Quản lý hóa đơn nhập - Văn Phú Casio'
      },
      {
        path: 'quan-ly-nha-cung-cap',
        component: ManageSupplierComponent,
        title: 'Quản lý nhà cung cấp - Văn Phú Casio'
      },
      {
        path: 'ho-so',
        component: ProfileComponent,
        title: 'Hồ sơ người dùng - Văn Phú Casio'
      },
      {
        path: 'quan-ly-quyen',
        component: ManageRoleComponent,
        title: 'Quản lý quyền - Văn Phú Casio'
      }
    ]
  },
  {
    path:'**', 
    component: Error404Component,
    title: 'Lỗi 404 - Casio Văn Phú'
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {
    scrollPositionRestoration: 'enabled'
  })],
  exports: [RouterModule]
})
export class AppRoutingModule { }
