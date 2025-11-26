# 📡 PHẦN 5: API, TESTING VÀ DEPLOYMENT

## 🎯 Mục tiêu tổng quát

- Hiểu và xây dựng được RESTful API bằng Django REST Framework.
- Biết cách bảo vệ API bằng hệ thống xác thực và phân quyền.
- Viết được các bài test (unit test) để đảm bảo chất lượng và sự ổn định của code.
- Nắm được các khái niệm cơ bản về deployment và các bước để đưa một ứng dụng Django lên môi trường internet thực tế.
- Chuyển đổi ứng dụng quản lý danh bạ thành một API backend sẵn sàng cho các ứng dụng khác (ví dụ: mobile app, frontend framework) sử dụng và chuẩn bị cho việc deployment.

## 🧑‍🏫 Bài 1: Giới thiệu API và Django REST Framework (DRF)

### API là gì?

- **API (Application Programming Interface - Giao diện lập trình ứng dụng)** là một tập hợp các quy tắc và cơ chế cho phép các ứng dụng phần mềm khác nhau giao tiếp với nhau.
- Trong phát triển web, API thường dùng để chỉ **Web API**, cho phép ứng dụng frontend (trình duyệt, mobile app) lấy dữ liệu từ server mà không cần tải lại toàn bộ trang.
- **REST (Representational State Transfer)** là một kiểu kiến trúc phổ biến để thiết kế API, sử dụng các phương thức HTTP (GET, POST, PUT, DELETE) để thực hiện các thao tác CRUD (Create, Read, Update, Delete) trên dữ liệu.

Sơ đồ minh họa:

```text
+--------------+        +-----------------+        +---------------------+
|              |        |                 |        |                     |
|  Mobile App  | -----> |                 | <----> |      Database       |
| (Client 1)   |        |                 |        |                     |
+--------------+        |   Web Server    |        +---------------------+
                        |    (Your API)   |
+--------------+        |                 |        +---------------------+
|              |        |                 |        |                     |
|   React/Vue  | -----> |                 | <----> |   3rd Party Service |
|  App (Client 2)      |                 |        |    (e.g. email)     |
+--------------+        +-----------------+        +---------------------+
```

### Django REST Framework (DRF)

- Là một bộ công cụ mạnh mẽ và linh hoạt để xây dựng Web API trong Django.
- Cung cấp sẵn các tính năng quan trọng:
  - **Serialization**: Chuyển đổi các đối tượng phức tạp (như Django models) thành các định dạng dễ truyền tải (như JSON) và ngược lại.
  - **Authentication & Permissions**: Hệ thống xác thực và phân quyền mạnh mẽ.
  - **Generic Views**: Các view dựng sẵn giúp xây dựng API nhanh chóng.
  - **Tự động tạo tài liệu API**: Giao diện web có thể duyệt được cho API của bạn.

### Xây dựng API đầu tiên với DRF

1. **Cài đặt và cấu hình**:

    ```bash
    pip install djangorestframework
    ```

    Trong `settings.py`, thêm `rest_framework` vào `INSTALLED_APPS`.

2. **Tạo Serializer**: Serializer giống như Django Form, nhưng dùng cho API. Nó định nghĩa dữ liệu nào sẽ được chuyển đổi sang JSON.
    `contacts/serializers.py` (tạo file mới):

    ```python
    from rest_framework import serializers
    from .models import Contact

    class ContactSerializer(serializers.ModelSerializer):
        class Meta:
            model = Contact
            fields = ['id', 'name', 'phone', 'email', 'created_at'] # Các trường muốn expose ra API
    ```

3. **Tạo API View**:
    `contacts/views.py`:

    ```python
    from rest_framework.decorators import api_view
    from rest_framework.response import Response
    from .models import Contact
    from .serializers import ContactSerializer

    @api_view(['GET']) # Chỉ cho phép request GET
    def contact_api_list(request):
        contacts = Contact.objects.all()
        serializer = ContactSerializer(contacts, many=True) # many=True vì có nhiều đối tượng
        return Response(serializer.data)
    ```

4. **Tạo URL cho API**:
    `contacts/urls.py`:

    ```python
    from django.urls import path
    from . import views

    urlpatterns = [
        # ... các URL cũ
        path('api/list/', views.contact_api_list, name='contact-api-list'),
    ]
    ```

    Chạy server và truy cập `http://127.0.0.1:8000/contacts/api/list/`. Bạn sẽ thấy một giao diện web đẹp mắt do DRF tạo ra, hiển thị danh sách liên hệ dưới dạng JSON.

## 🧑‍🏫 Bài 2: Authentication và Permissions trong DRF

### Authentication (Xác thực)

Xác thực là quá trình xác định *bạn là ai*. DRF hỗ trợ nhiều cơ chế:

- **SessionAuthentication**: Dùng session của Django, phù hợp cho các web app truyền thống.
- **TokenAuthentication**: Cơ chế phổ biến cho API. Client gửi một token duy nhất trong mỗi request để chứng minh danh tính.
- **JWT Authentication**: Một dạng token hiện đại và an toàn hơn.

### Permissions (Phân quyền)

Sau khi xác thực, phân quyền sẽ quyết định *bạn được làm gì*.

- `IsAuthenticated`: Chỉ những người dùng đã đăng nhập mới có quyền truy cập.
- `IsAdminUser`: Chỉ admin (superuser) mới có quyền truy cập.
- `IsAuthenticatedOrReadOnly`: Ai cũng có thể xem (GET), nhưng chỉ người dùng đã đăng nhập mới có thể thay đổi (POST, PUT, DELETE).
- Tự tạo quyền riêng.

### Áp dụng vào API

1. **Sử dụng Token Authentication**:
    - Trong `settings.py`, thêm `rest_framework.authtoken` vào `INSTALLED_APPS`.
    - Chạy `python manage.py migrate` để tạo bảng lưu token.
    - Cấu hình DRF để sử dụng token mặc định:

      ```python
      # settings.py
      REST_FRAMEWORK = {
          'DEFAULT_AUTHENTICATION_CLASSES': [
              'rest_framework.authentication.TokenAuthentication',
          ],
          'DEFAULT_PERMISSION_CLASSES': [
              'rest_framework.permissions.IsAuthenticated', # Mặc định yêu cầu đăng nhập
          ]
      }
      ```

2. **Bảo vệ View**:
    `contacts/views.py`:

    ```python
    # ...
    from rest_framework.permissions import IsAuthenticated
    from rest_framework.decorators import permission_classes

    @api_view(['GET', 'POST'])
    @permission_classes([IsAuthenticated]) # Yêu cầu xác thực cho view này
    def contact_api_list(request):
        if request.method == 'GET':
            # ... code cũ
        elif request.method == 'POST':
            serializer = ContactSerializer(data=request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=201) # 201 Created
            return Response(serializer.errors, status=400) # 400 Bad Request
    ```

    Bây giờ, nếu truy cập API mà không cung cấp token, bạn sẽ nhận được lỗi "Authentication credentials were not provided."

## 🧑‍🏫 Bài 3: Viết Test cho ứng dụng Django

### Tại sao phải viết Test?

- **Tự tin khi thay đổi code**: Đảm bảo các thay đổi mới không làm hỏng chức năng cũ (chống lỗi hồi quy - regression).
- **Tài liệu sống**: Test case mô tả chính xác cách code của bạn hoạt động.
- **Thiết kế tốt hơn**: Viết test buộc bạn phải suy nghĩ về cách code được sử dụng và giúp thiết kế các thành phần độc lập, dễ kiểm thử hơn.

### Unit Test và Integration Test

- **Unit Test**: Kiểm tra một "đơn vị" code nhỏ và độc lập (một hàm, một phương thức của class).
- **Integration Test**: Kiểm tra sự tương tác giữa nhiều đơn vị với nhau (ví dụ: một request đi từ URL -> View -> Model -> Database).

### Viết Test trong Django

Django sử dụng thư viện `unittest` của Python và cung cấp các lớp tiện ích. Test được viết trong file `tests.py` của mỗi app.

`contacts/tests.py`:

```python
from django.test import TestCase
from django.contrib.auth.models import User
from rest_framework.test import APIClient
from .models import Contact

class ContactAPITests(TestCase):
    def setUp(self):
        """Hàm này chạy trước mỗi test case."""
        # Tạo một user để test
        self.user = User.objects.create_user(username='testuser', password='password123')
        
        # Tạo một contact mẫu
        self.contact = Contact.objects.create(
            name='Test Contact', 
            phone='123456789', 
            email='test@example.com'
        )
        
        # Tạo một client để giả lập các request API
        self.client = APIClient()
        self.client.force_authenticate(user=self.user) # Giả lập đăng nhập

    def test_contact_list_api_get(self):
        """Kiểm tra việc lấy danh sách contacts qua API (GET)."""
        response = self.client.get('/contacts/api/list/') # Giả lập request GET
        
        # Kiểm tra status code là 200 OK
        self.assertEqual(response.status_code, 200)
        
        # Kiểm tra dữ liệu trả về có chứa contact mẫu không
        self.assertEqual(len(response.data), 1)
        self.assertEqual(response.data[0]['name'], 'Test Contact')

    def test_contact_create_api_post(self):
        """Kiểm tra việc tạo contact mới qua API (POST)."""
        data = {'name': 'New Contact', 'phone': '987654321'}
        response = self.client.post('/contacts/api/list/', data, format='json')
        
        # Kiểm tra status code là 201 Created
        self.assertEqual(response.status_code, 201)
        
        # Kiểm tra xem contact mới đã thực sự được tạo trong database chưa
        self.assertTrue(Contact.objects.filter(name='New Contact').exists())

```

Chạy test bằng lệnh: `python manage.py test`

## 🧑‍🏫 Bài 4: Deployment - Triển khai ứng dụng

### Môi trường Development vs. Production

- **Development (Phát triển)**: Môi trường trên máy cá nhân của bạn. Dùng `DEBUG = True`, server phát triển của Django, database SQLite. Tối ưu cho việc viết và gỡ lỗi.
- **Production (Sản phẩm)**: Môi trường thực tế trên internet. `DEBUG = False`, server ứng dụng (Gunicorn), web server (Nginx), database mạnh mẽ (PostgreSQL). Tối ưu cho hiệu năng, bảo mật và ổn định.

### Các thành phần của một môi trường Production

Sơ đồ kiến trúc Production đơn giản:

```text
+------+   (Request)   +-------+   (Forwards to)   +----------+   (Talks to)   +----------+
| User | ------------> | Nginx | ----------------> | Gunicorn | -------------> | Django   |
+------+               +-------+                   +----------+                |   App    |
                         ^   |                                                 +----V-----+
                         |   |                                                      |
                  (Serves static files)                                          (Talks to)
                         |   |                                                      |
                         |   V                                                 +----V-----+
                       +--------------+                                        | Database |
                       | static/media |                                        | (PostgreSQL)|
                       +--------------+                                        +----------+
```

- **Web Server (Nginx)**: Nhận request từ người dùng. Phục vụ các file tĩnh (CSS, JS) trực tiếp, và chuyển các request động đến Application Server.
- **Application Server (Gunicorn)**: Chạy ứng dụng Python/Django của bạn, có khả năng xử lý nhiều request đồng thời.
- **Database (PostgreSQL)**: Hệ quản trị CSDL mạnh mẽ, phù hợp cho môi trường production.

### Triển khai lên một Platform (PaaS)

Với người mới bắt đầu, sử dụng một PaaS (Platform as a Service) như **Render.com** hay **Heroku** là cách dễ nhất. Họ sẽ quản lý Nginx, Gunicorn, Database cho bạn.

Các bước chuẩn bị chính:

1. **Cài đặt Gunicorn**: `pip install gunicorn`
2. **Cài đặt thư viện database**: `pip install psycopg2-binary`
3. **Cài đặt WhiteNoise** để phục vụ file tĩnh: `pip install whitenoise` và cấu hình trong `settings.py`.
4. **Tạo file `requirements.txt`**: `pip freeze > requirements.txt` để liệt kê các thư viện cần cài.
5. **Tạo file `Procfile`**: Chỉ cho PaaS biết cách chạy ứng dụng của bạn.
    `Procfile`:

    ```text
    web: gunicorn contactbook.wsgi --log-file -
    ```

6. **Cấu hình `settings.py` cho production**:
    - `DEBUG = False`
    - `SECRET_KEY` lấy từ biến môi trường.
    - `ALLOWED_HOSTS` chứa tên miền của bạn.
    - Cấu hình database để kết nối đến PostgreSQL.
7. Đẩy code lên GitHub và kết nối với tài khoản PaaS của bạn.

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: API hóa và Chuẩn bị Deployment cho App Danh bạ

### Mô tả bài toán

Phát triển ứng dụng Django Quản lý Danh bạ từ Phần 4 thành một backend API hoàn chỉnh. Viết test để đảm bảo API hoạt động đúng và chuẩn bị các file cần thiết để có thể triển khai ứng dụng lên một nền tảng PaaS.

### Yêu cầu

1. **Xây dựng RESTful API**:
    - Sử dụng Django REST Framework.
    - Tạo một `ContactSerializer`.
    - Xây dựng các API endpoint cho tất cả các thao tác CRUD:
      - `GET /api/contacts/`: Lấy danh sách tất cả liên hệ.
      - `POST /api/contacts/`: Tạo một liên hệ mới.
      - `GET /api/contacts/<int:pk>/`: Lấy chi tiết một liên hệ.
      - `PUT /api/contacts/<int:pk>/`: Cập nhật toàn bộ một liên hệ.
      - `DELETE /api/contacts/<int:pk>/`: Xóa một liên hệ.
      - (Gợi ý: Sử dụng các lớp `GenericAPIView` hoặc `ModelViewSet` của DRF để làm nhanh hơn).

2. **Bảo mật API**:
    - Thiết lập `TokenAuthentication` làm cơ chế xác thực mặc định.
    - Thiết lập `IsAuthenticated` làm quyền mặc định. Người dùng phải có token hợp lệ để tương tác với API.

3. **Viết Unit Tests**:
    - Trong `contacts/tests.py`, viết các test case để kiểm tra:
      - Endpoint lấy danh sách liên hệ (`GET /api/contacts/`) hoạt động đúng.
      - Endpoint tạo liên hệ (`POST /api/contacts/`) hoạt động đúng.
      - Việc truy cập API khi chưa xác thực bị từ chối (trả về status 401 hoặc 403).

4. **Chuẩn bị Deployment**:
    - Cài đặt `gunicorn`, `psycopg2-binary`, `whitenoise`.
    - Tạo file `requirements.txt`.
    - Tạo file `Procfile`.
    - Sửa đổi `settings.py` để có thể đọc các cấu hình nhạy cảm (như `SECRET_KEY`, `DATABASE_URL`) từ biến môi trường, và thiết lập `DEBUG=False` nếu biến môi trường cho biết đang ở production.

5. **(Tùy chọn) Triển khai thực tế**:
    - Tạo một tài khoản miễn phí trên Render.com.
    - Tạo một project mới, kết nối với repo GitHub của bạn.
    - Cấu hình các biến môi trường cần thiết và triển khai ứng dụng.
