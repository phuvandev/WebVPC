import { NgModule } from '@angular/core';
import { Error404Component } from './components/error404/error404.component';
import { BrowserModule } from '@angular/platform-browser';

import { HttpClientModule } from '@angular/common/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AngularEditorModule } from '@kolkov/angular-editor';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { AdminHeaderComponent } from './partials/admin-header/admin-header.component';
import { AdminFooterComponent } from './partials/admin-footer/admin-footer.component';
import { ClientHeaderComponent } from './partials/client-header/client-header.component';
import { ClientFooterComponent } from './partials/client-footer/client-footer.component';
import { HomeComponent } from './components/client/home/home.component';
import { AboutComponent } from './components/client/about/about.component';
import { ContactComponent } from './components/client/contact/contact.component';
import { CategoryComponent } from './components/client/category/category.component';
import { BlogComponent } from './components/client/blog/blog.component';
import { BlogDetailComponent } from './components/client/blog-detail/blog-detail.component';
import { ProductComponent } from './components/client/product/product.component';
import { CartComponent } from './components/client/cart/cart.component';
import { CheckoutComponent } from './components/client/checkout/checkout.component';
import { SearchComponent } from './components/client/search/search.component';
import { AccountComponent } from './components/client/account/account.component';
import { AdminLayoutComponent } from './partials/admin-layout/admin-layout.component';
import { ClientLayoutComponent } from './partials/client-layout/client-layout.component';

import { CarouselModule } from 'ngx-owl-carousel-o';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgxPaginationModule } from 'ngx-pagination';
import { CommonModule } from '@angular/common';

import { DashboardComponent } from './components/admin/dashboard/dashboard.component';
import { ManageMenuComponent } from './components/admin/manage-menu/manage-menu.component';
import { AdminSidebarComponent } from './partials/admin-sidebar/admin-sidebar.component';
import { ManageProductComponent } from './components/admin/manage-product/manage-product.component';
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
import { ManageOrderComponent } from './components/admin/manage-order/manage-order.component';
import { ManageSupplierComponent } from './components/admin/manage-supplier/manage-supplier.component';
import { NgSelectModule } from '@ng-select/ng-select';
import { ProfileComponent } from './components/admin/profile/profile.component';
import { ManageRoleComponent } from './components/admin/manage-role/manage-role.component';
import { LoginComponent } from './components/client/login/login.component';
import { RegisterComponent } from './components/client/register/register.component';
import { OtherPaymentComponent } from './components/client/other-payment/other-payment.component';

@NgModule({
  declarations: [
    AppComponent,
    AdminHeaderComponent,
    AdminFooterComponent,
    ClientHeaderComponent,
    ClientFooterComponent,
    HomeComponent,
    AboutComponent,
    ContactComponent,
    CategoryComponent,
    BlogComponent,
    BlogDetailComponent,
    ProductComponent,
    CartComponent,
    CheckoutComponent,
    SearchComponent,
    AccountComponent,
    AdminLayoutComponent,
    ClientLayoutComponent,
    LoginComponent,
    RegisterComponent,
    Error404Component,
    DashboardComponent,
    ManageMenuComponent,
    AdminSidebarComponent,
    ManageProductComponent,
    ManageSlideComponent,
    ManageBannerComponent,
    ManageAboutComponent,
    ManageBlogComponent,
    ManageContactComponent,
    ManageSettingComponent,
    ManageCategoryComponent,
    ManagePriceComponent,
    ManageStaffComponent,
    ManageCustomerComponent,
    ManageImportInvoiceComponent,
    ManageOrderComponent,
    ManageSupplierComponent,
    ProfileComponent,
    ManageRoleComponent,
    OtherPaymentComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    CarouselModule,
    BrowserAnimationsModule,
    NgxPaginationModule,
    ReactiveFormsModule,
    CommonModule,
    AngularEditorModule,
    NgSelectModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
