# Sử dụng một phiên bản PHP với Apache
FROM php:8.2-apache

# (Tùy chọn) Thêm thông tin về người tạo image
LABEL maintainer="yourname@example.com"

# Đặt thư mục làm việc
WORKDIR /var/www/html

# Sao chép file index.php vào thư mục làm việc
COPY index.php .

# (Cho tùy chọn nâng cao với bộ đếm)
# Tạo thư mục 'data' và cấp quyền ghi cho user www-data (user mà Apache chạy)
# Điều này cho phép PHP ghi file counter.txt vào đó.
RUN mkdir data && chown www-data:www-data data \
  && chmod 755 data
# Đảm bảo thư mục data có thể được truy cập bởi Apache
# và có thể được ghi bởi www-data (do chown)

# Apache mặc định lắng nghe trên port 80
EXPOSE 80

# Lệnh mặc định để chạy Apache đã được cấu hình trong base image.
# CMD ["apache2-foreground"]
