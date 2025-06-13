# 🚀 PHẦN 4: PHÁT TRIỂN WEB CHUYÊN NGHIỆP VỚI DJANGO

- [🚀 PHẦN 4: PHÁT TRIỂN WEB CHUYÊN NGHIỆP VỚI DJANGO](#-phần-4-phát-triển-web-chuyên-nghiệp-với-django)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: Giới thiệu Django và Cấu trúc MVT](#-bài-1-giới-thiệu-django-và-cấu-trúc-mvt)
    - [Django là gì?](#django-là-gì)
    - [Kiến trúc Model-View-Template (MVT)](#kiến-trúc-model-view-template-mvt)
    - [Cài đặt và Tạo dự án Django đầu tiên](#cài-đặt-và-tạo-dự-án-django-đầu-tiên)
  - [🧑‍🏫 Bài 2: Django Models và ORM](#-bài-2-django-models-và-orm)
    - [Django Models là gì?](#django-models-là-gì)
    - [Tạo Model và Migration](#tạo-model-và-migration)
    - [Tương tác với dữ liệu qua ORM Shell](#tương-tác-với-dữ-liệu-qua-orm-shell)
  - [🧑‍🏫 Bài 3: Django Views và Templates](#-bài-3-django-views-và-templates)
    - [Function-Based Views](#function-based-views)
    - [Django Template Language (DTL)](#django-template-language-dtl)
    - [URL Routing trong Django](#url-routing-trong-django)
  - [🧑‍🏫 Bài 4: Django Admin và Forms](#-bài-4-django-admin-và-forms)
    - [Khám phá Django Admin](#khám-phá-django-admin)
    - [Django Forms](#django-forms)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Xây dựng lại Web App Quản lý Danh bạ với Django](#-bài-tập-lớn-cuối-phần-xây-dựng-lại-web-app-quản-lý-danh-bạ-với-django)
    - [Mô tả bài toán](#mô-tả-bài-toán)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Hiểu rõ triết lý "Batteries-included" của Django.
- Nắm vững kiến trúc Model-View-Template (MVT).
- Sử dụng Django ORM để định nghĩa mô hình dữ liệu và tương tác với database một cách an toàn.
- Xây dựng các trang web động bằng Django Views và Templates.
- Tận dụng sức mạnh của Django Admin để quản lý dữ liệu mà không cần viết code.
- Sử dụng Django Forms để xử lý và xác thực dữ liệu từ người dùng một cách hiệu quả.
- Xây dựng lại ứng dụng từ Phần 3 trên nền tảng Django, sử dụng cơ sở dữ liệu thực sự thay vì file JSON.

---

## 🧑‍🏫 Bài 1: Giới thiệu Django và Cấu trúc MVT

### Django là gì?

- Django là một web framework bậc cao, miễn phí và mã nguồn mở của Python.
- Triết lý "Batteries-included" (bao gồm sẵn pin): Cung cấp gần như mọi thứ bạn cần để xây dựng một ứng dụng web hoàn chỉnh (ORM, Admin, Authentication, Forms, Security...).
- Thúc đẩy việc phát triển nhanh, thiết kế sạch sẽ và thực dụng.
- Phù hợp cho các dự án lớn, phức tạp, yêu cầu tính bảo mật và khả năng mở rộng cao.

### Kiến trúc Model-View-Template (MVT)

Django theo một biến thể của kiến trúc MVC (Model-View-Controller) gọi là MVT.

- **Model**: Định nghĩa cấu trúc dữ liệu, là cầu nối duy nhất và đáng tin cậy đến database. Nó không quan tâm dữ liệu sẽ được hiển thị như thế nào.
- **View**: Là nơi chứa logic xử lý. Nó nhận request, tương tác với Model để lấy dữ liệu, và quyết định Template nào sẽ được dùng để hiển thị dữ liệu đó.
- **Template**: Là lớp trình bày (presentation layer). Nó chỉ chịu trách nhiệm hiển thị dữ liệu nhận được từ View dưới dạng HTML.

Sơ đồ luồng xử lý trong Django:
```
(Internet)
    |
    V
 (User's Browser sends a Request to a URL)
    |
    |
+---V--------------------------+
|      DJANGO PROJECT          |
|   +--------------------+     |
|   | urls.py (Router)   | ----> Tìm URL phù hợp và gọi View tương ứng
|   +--------------------+     |
|              |               |
|              V               |
|   +--------------------+     |
|   |       Views.py     | <---(3) View quyết định Template nào để render
|   | (Logic xử lý)      | ----(2) Gửi dữ liệu cho Template ---> +----------------+
|   |  |                 |                                      | Template (.html)|
|   +--|-----------------+                                      | (Hiển thị data)|
|      |                                                        +-------^--------+
|      +----(1) Tương tác với Model để lấy/lưu data ----+
|                                                      |
|   +--------------------+                             V
|   |      Models.py     | <----------------> +-----------------+
|   | (Cấu trúc data)    |    (Django ORM)    |    Database     |
|   +--------------------+                    +-----------------+
|                                                              |
+--------------------------------------------------------------+
```

### Cài đặt và Tạo dự án Django đầu tiên

1.  **Cài đặt Django**:
    ```bash
    pip install django
    ```
2.  **Tạo một project**:
    ```bash
    django-admin startproject myproject .
    ```
    (Dấu `.` để tạo project trong thư mục hiện tại). Cấu trúc thư mục sẽ là:
    ```
    myproject/
    ├── myproject/
    │   ├── __init__.py
    │   ├── asgi.py
    │   ├── settings.py  <-- Cấu hình project
    │   ├── urls.py      <-- Định tuyến URL chính
    │   └── wsgi.py
    └── manage.py        <-- Công cụ dòng lệnh để quản lý project
    ```
3.  **Tạo một app**: Một project Django được tạo thành từ nhiều app, mỗi app đảm nhiệm một chức năng riêng.
    ```bash
    python manage.py startapp myapp
    ```
    Bây giờ cấu trúc sẽ có thêm thư mục `myapp`.
4.  **Đăng ký app**: Mở `myproject/settings.py` và thêm `myapp` vào `INSTALLED_APPS`:
    ```python
    INSTALLED_APPS = [
        # ...
        'myapp.apps.MyappConfig', # Hoặc chỉ cần 'myapp'
    ]
    ```
5.  **Chạy server**:
    ```bash
    python manage.py runserver
    ```
    Truy cập `http://127.0.0.1:8000` để xem trang chào mừng của Django.

---

## 🧑‍🏫 Bài 2: Django Models và ORM

### Django Models là gì?

- Một model là một lớp Python kế thừa từ `django.db.models.Model`.
- Mỗi thuộc tính của lớp model đại diện cho một cột trong bảng cơ sở dữ liệu.
- Django sử dụng một công nghệ gọi là **Object-Relational Mapping (ORM)**, cho phép bạn tương tác với database (SQL) bằng cách sử dụng code Python thay vì viết các câu lệnh SQL trực tiếp.

### Tạo Model và Migration

1.  **Định nghĩa Model**: Mở `myapp/models.py` và định nghĩa model cho sản phẩm.
    ```python
    # myapp/models.py
    from django.db import models

    class Product(models.Model):
        name = models.CharField(max_length=200)
        price = models.DecimalField(max_digits=10, decimal_places=2)
        description = models.TextField(blank=True, null=True) # Có thể để trống
        created_at = models.DateTimeField(auto_now_add=True) # Tự động thêm ngày tạo

        def __str__(self):
            # Hiển thị tên sản phẩm trong Django Admin
            return self.name
    ```
2.  **Tạo Migrations**: Django sẽ so sánh model của bạn với database hiện tại và tạo ra một file "migration" mô tả những thay đổi cần thiết.
    ```bash
    python manage.py makemigrations
    ```
3.  **Áp dụng Migration**: Lệnh này sẽ thực thi các file migration, tạo ra bảng `myapp_product` trong database.
    ```bash
    python manage.py migrate
    ```
    (Mặc định Django sử dụng SQLite, một database đơn giản dựa trên file).

### Tương tác với dữ liệu qua ORM Shell

Django cung cấp một shell tương tác đã nạp sẵn môi trường project của bạn.
```bash
python manage.py shell
```
Bên trong shell:
```python
>>> from myapp.models import Product

# Tạo một đối tượng mới
>>> p1 = Product(name="Laptop XYZ", price=1200.50, description="Mẫu laptop mới nhất")
>>> p1.save()

# Lấy tất cả sản phẩm
>>> all_products = Product.objects.all()
>>> print(all_products)
<QuerySet [<Product: Laptop XYZ>]>

# Lọc sản phẩm
>>> specific_product = Product.objects.get(id=1)
>>> print(specific_product.name)
Laptop XYZ

# Cập nhật
>>> specific_product.price = 1150.00
>>> specific_product.save()

# Xóa
>>> specific_product.delete()
```
---

## 🧑‍🏫 Bài 3: Django Views và Templates

### Function-Based Views

View là một hàm Python nhận vào một đối tượng `request` và trả về một đối tượng `response`.

`myapp/views.py`:
```python
from django.shortcuts import render
from .models import Product

def product_list(request):
    # Sử dụng ORM để lấy tất cả sản phẩm, sắp xếp theo tên
    products = Product.objects.all().order_by('name')
    
    # Tạo một context dictionary để truyền dữ liệu tới template
    context = {
        'products': products,
        'page_title': 'Danh sách sản phẩm'
    }
    
    # Render template và truyền context vào
    return render(request, 'myapp/product_list.html', context)
```

### Django Template Language (DTL)

Rất giống với Jinja2 của Flask nhưng có một vài khác biệt nhỏ về cú pháp.

Tạo thư mục `templates/myapp/` bên trong app `myapp`.
`myapp/templates/myapp/product_list.html`:
```html
<!DOCTYPE html>
<html>
<head>
    <title>{{ page_title }}</title>
</head>
<body>
    <h1>{{ page_title }}</h1>
    
    {% if products %}
        <ul>
            <!-- Vòng lặp trong DTL -->
            {% for product in products %}
                <li>
                    {{ product.name }} - ${{ product.price }}
                </li>
            {% endfor %}
        </ul>
    {% else %}
        <p>Không có sản phẩm nào.</p>
    {% endif %}
</body>
</html>
```

### URL Routing trong Django

1.  **Tạo file `urls.py` cho app**:
    `myapp/urls.py`:
    ```python
    from django.urls import path
    from . import views

    urlpatterns = [
        # path(route, view_function, name)
        path('', views.product_list, name='product-list'),
    ]
    ```
2.  **Liên kết URL của app vào project**:
    `myproject/urls.py`:
    ```python
    from django.contrib import admin
    from django.urls import path, include # Thêm include

    urlpatterns = [
        path('admin/', admin.site.urls),
        path('products/', include('myapp.urls')), # Bao gồm các URL từ myapp
    ]
    ```
Bây giờ, khi bạn truy cập `http://127.0.0.1:8000/products/`, nó sẽ gọi hàm `product_list` trong `myapp/views.py`.

---

## 🧑‍🏫 Bài 4: Django Admin và Forms

### Khám phá Django Admin

Đây là một trong những tính năng mạnh mẽ nhất của Django. Nó tự động tạo ra một giao diện quản trị hoàn chỉnh cho các model của bạn.

1.  **Tạo tài khoản Superuser**:
    ```bash
    python manage.py createsuperuser
    ```
    (Làm theo hướng dẫn để tạo username, email, password)
2.  **Đăng ký Model với Admin**:
    `myapp/admin.py`:
    ```python
    from django.contrib import admin
    from .models import Product

    # Đăng ký model Product để nó xuất hiện trong trang admin
    admin.site.register(Product)
    ```
3.  **Truy cập trang Admin**: Chạy server và vào `http://127.0.0.1:8000/admin/`. Đăng nhập với tài khoản superuser vừa tạo. Bạn sẽ thấy một giao diện để Thêm, Sửa, Xóa các sản phẩm một cách trực quan.

### Django Forms

Django Forms giúp tạo, xác thực và xử lý các form HTML một cách an toàn và hiệu quả.

1.  **Tạo Form**:
    `myapp/forms.py` (tạo file mới):
    ```python
    from django import forms
    from .models import Product

    class ProductForm(forms.ModelForm):
        class Meta:
            model = Product
            fields = ['name', 'price', 'description'] # Các trường muốn hiển thị trong form
    ```
2.  **Sử dụng Form trong View**:
    `myapp/views.py`:
    ```python
    from django.shortcuts import render, redirect
    from .models import Product
    from .forms import ProductForm

    def add_product(request):
        if request.method == 'POST':
            form = ProductForm(request.POST)
            if form.is_valid(): # Tự động kiểm tra dữ liệu
                form.save() # Lưu đối tượng mới vào database
                return redirect('product-list') # Chuyển hướng về trang danh sách
        else:
            form = ProductForm() # Tạo một form trống
        
        context = {'form': form}
        return render(request, 'myapp/add_product.html', context)
    ```
3.  **Hiển thị Form trong Template**:
    `myapp/templates/myapp/add_product.html`:
    ```html
    <h1>Thêm sản phẩm mới</h1>
    <form method="post">
        {% csrf_token %} <!-- Bắt buộc để bảo mật -->
        {{ form.as_p }} <!-- Django tự động render các thẻ input -->
        <button type="submit">Lưu</button>
    </form>
    ```
4.  **Thêm URL cho view mới**:
    `myapp/urls.py`:
    ```python
    # ...
    path('add/', views.add_product, name='add-product'),
    ```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Xây dựng lại Web App Quản lý Danh bạ với Django

### Mô tả bài toán

Xây dựng lại ứng dụng Quản lý Danh bạ bằng Django, thay thế hoàn toàn file `contacts.json` bằng cơ sở dữ liệu (SQLite mặc định) và tận dụng các tính năng mạnh mẽ của Django.

### Yêu cầu

1.  **Project và App Setup**:
    - Tạo một project Django tên là `contactbook`.
    - Tạo một app bên trong tên là `contacts`.

2.  **Model**:
    - Trong `contacts/models.py`, tạo một model `Contact` với các trường:
      - `name` (CharField)
      - `phone` (CharField)
      - `email` (EmailField, cho phép trống)
      - `created_at` (DateTimeField, tự động thêm ngày tạo)
    - Chạy `makemigrations` và `migrate` để tạo bảng trong database.

3.  **Django Admin**:
    - Tạo một tài khoản `superuser`.
    - Đăng ký model `Contact` vào `contacts/admin.py`.
    - Truy cập trang admin và thử thêm vài liên hệ bằng tay để kiểm tra.

4.  **Views và Templates**:
    - **Danh sách liên hệ (`/`)**:
      - Tạo một view để lấy tất cả liên hệ từ database và hiển thị chúng trong một template `contact_list.html`.
      - Template hiển thị dữ liệu trong một bảng HTML.
    - **Chi tiết liên hệ (`/contact/<int:pk>/`)**:
      - Tạo một view để lấy một liên hệ duy nhất dựa trên `primary key` (pk) và hiển thị thông tin chi tiết trong template `contact_detail.html`.
    - **Thêm liên hệ (`/add/`)**:
      - Tạo một `ModelForm` cho model `Contact`.
      - Tạo một view để xử lý việc thêm liên hệ mới, sử dụng form vừa tạo. Template là `contact_form.html`.
      - Sau khi thêm thành công, chuyển hướng người dùng về trang danh sách.

5.  **URLs**:
    - Cấu hình `urls.py` cho app `contacts` và include nó vào `urls.py` của project.

6.  **(Tùy chọn nâng cao)**
    - Thêm chức năng **Sửa (`/contact/<int:pk>/edit/`)** và **Xóa (`/contact/<int:pk>/delete/`)** liên hệ, cũng sử dụng Django Forms.
