# Môi Trường Phát Triển LEMP với Docker

> 🌏 **Ngôn ngữ/Language**: [English](README.md) | [Tiếng Việt](README_VI.md)

Một stack **LEMP hoàn chỉnh** (Linux, Nginx, MySQL, PHP) được container hóa cho phát triển web local sử dụng Docker Compose.

🚀 **Không cần cấu hình** - Khởi động trong vài giây với pre-built images!

---

## ✨ Tính Năng

- ⚡ **Cài Đặt Nhanh** - Dùng images có sẵn, không cần build
- 🐘 **PHP 8.2** với các extension phổ biến (PDO, GD, ZIP, INTL,...)
- 🌐 **Nginx** với gzip và security headers
- 🗄️ **MySQL 8.0** với health checks
- 🛠️ **phpMyAdmin** đã bao gồm để quản lý database
- 🔒 **Bảo Mật** - Best practices mặc định
- 📁 **Volume mounting** - Sửa code local, thay đổi ngay lập tức
- 🔄 **Auto-restart** - Tự động khởi động lại khi lỗi

---

## 📋 So Sánh Nhanh

| Phương Thức | ThờI Gian | Trường Hợp | Lệnh |
|-------------|-----------|------------|------|
| **Pull Images** ⭐ | ~30 giây | Bắt đầu nhanh, giống production | `docker-compose up -d` |
| **Build Local** | ~3-5 phút | Phát triển, tùy chỉnh images | `docker-compose -f docker-compose.build.yml up -d --build` |

---

## 🏁 Hướng Dẫn Nhanh

### Cách 1: Pull Pre-built Images (Khuyến nghị ⭐)

Cách nhanh nhất để bắt đầu. Không cần build!

```bash
# 1. Clone repository
git clone https://github.com/quocbaodsk/lemp-docker.git
cd lemp-docker

# 2. Đặt Docker Hub username (thay bằng username thực tế)
export DOCKER_USERNAME=baocloud

# 3. Khởi động tất cả dịch vụ
docker-compose up -d
```

Xong! LEMP stack của bạn đã chạy. 🎉

### Cách 2: Build Images Local

Build từ source nếu bạn muốn tùy chỉnh images:

```bash
# 1. Clone repository
git clone https://github.com/quocbaodsk/lemp-docker.git
cd lemp-docker

# 2. (Tùy chọn) Chỉnh sửa file .env để tùy chỉnh
# vim .env

# 3. Build và khởi động (dùng docker-compose.build.yml)
docker-compose -f docker-compose.build.yml up -d --build
```

---

## 🔍 Kiểm Tra Cài Đặt

```bash
# Kiểm tra trạng thái container
docker-compose ps

# Xem logs
docker-compose logs -f

# Hoặc dịch vụ cụ thể
docker-compose logs -f php
```

---

## 🌐 Truy Cập Ứng Dụng

| URL | Dịch Vụ | Mô Tả |
|-----|---------|-------|
| http://localhost:8000 | **App của bạn** | Đặt file PHP trong `wwwroot/` |
| http://localhost:8001 | **phpMyAdmin** | Quản lý database (root/devops123) |

### Test PHP

```bash
# Tạo file test
echo "<?php phpinfo(); ?>" > wwwroot/index.php

# Truy cập http://localhost:8000
```

---

## 📁 Cấu Trúc Dự Án

```
.
├── config/                     # Các file cấu hình
│   ├── nginx/                 # Cấu hình Nginx
│   │   └── app.conf           # Cấu hình virtual host
│   └── php-fpm/               # Cấu hình PHP-FPM
│       └── custom.ini         # Thiết lập PHP tùy chỉnh
├── images/                     # File build Docker
│   ├── php.Dockerfile         # PHP 8.2 FPM
│   ├── php7.Dockerfile        # PHP 7.4 (thay thế)
│   ├── nginx.Dockerfile       # Nginx
│   └── mysql.Dockerfile       # MySQL 8.0
├── wwwroot/                    # Code ứng dụng PHP của bạn
├── data/                       # Lưu trữ dữ liệu MySQL
├── logs/                       # File log
├── docker-compose.yml          # Dùng pre-built images ⭐ (mặc định)
├── docker-compose.build.yml    # Build local 🔨 (tùy chỉnh)
├── .env                       # Biến môi trường
├── build-and-push.sh          # Script publish images
├── PUBLISH_GUIDE.md           # Hướng dẫn maintainer
└── README_VI.md               # File này
```

---

## 🐳 Images Có Sẵn

| Image | Tag | Kích Thước | Lệnh Pull |
|-------|-----|------------|-----------|
| `baocloud/lemp-php` | `8.2` | ~150MB | `docker pull baocloud/lemp-php:8.2` |
| `baocloud/lemp-nginx` | `latest` | ~25MB | `docker pull baocloud/lemp-nginx:latest` |
| `baocloud/lemp-mysql` | `8.0` | ~400MB | `docker pull baocloud/lemp-mysql:8.0` |

> 💡 Thay `yourname` bằng Docker Hub username thực tế

---

## 🛠️ Các Extension PHP Đã Cài

```
✓ pdo, pdo_mysql, mysqli    # Kết nối database
✓ gd                        # Xử lý ảnh
✓ zip                       # File nén
✓ intl                      # Quốc tế hóa
✓ bcmath                    # Hàm toán học
✓ mbstring                  # Chuỗi đa byte
✓ Composer                  # Quản lý dependency
```

---

## 🗄️ Kết Nối Database

### Từ Host (Bên ngoài)
```
Host:     localhost
Port:     3036
Username: root
Password: devops123
Database: app_db
```

### Từ PHP (Bên trong)
```php
<?php
$host = 'mysql';  // Dùng tên service làm host
$db   = 'app_db';
$user = 'root';
$pass = 'devops123';

$pdo = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
```

---

## ⚙️ Các Lệnh Thường Dùng

### Quản Lý Vòng ĐờI
```bash
# Khởi động dịch vụ (mặc định dùng pre-built)
docker-compose up -d

# Dừng dịch vụ
docker-compose down

# Khởi động lại dịch vụ cụ thể
docker-compose restart nginx

# Xem logs
docker-compose logs -f

# Dừng và xóa tất cả dữ liệu (⚠️ xóa database)
docker-compose down -v
```

### Làm Việc Bên Trong Containers
```bash
# Chạy script PHP
docker-compose exec php php script.php

# Chạy Composer
docker-compose exec php composer install

# MySQL CLI
docker-compose exec mysql mysql -u root -p

# Truy cập shell
docker-compose exec php sh
docker-compose exec nginx sh
```

---

## 🔒 Tính Năng Bảo Mật

- **Security Headers**
  - `X-Frame-Options: SAMEORIGIN`
  - `X-XSS-Protection: 1; mode=block`
  - `X-Content-Type-Options: nosniff`
  - `expose_php = Off`

- **Kiểm Soát Truy Cập**
  - Từ chối file ẩn (`.htaccess`, `.env`, v.v.)
  - Giới hạn thực thI PHP

- **Health Checks** - Tất cả dịch vụ được giám sát

---

## 📝 Cấu Hình

### Thiết Lập PHP (`config/php-fpm/custom.ini`)

| Thiết Lập | Giá Trị | Mô Tả |
|-----------|---------|-------|
| `memory_limit` | 512M | Giới hạn bộ nhớ script |
| `max_execution_time` | 300 | Timeout (giây) |
| `upload_max_filesize` | 512M | Kích thước upload tối đa |
| `post_max_size` | 512M | Kích thước POST tối đa |
| `max_input_vars` | 3000 | Giới hạn biến input |

### Biến Môi Trường (`.env`)

```env
MYSQL_ROOT_PASSWORD=devops123
MYSQL_DATABASE=app_db
MYSQL_USER=myuser
MYSQL_PASSWORD=password
TZ=Asia/Ho_Chi_Minh
```

---

## 🔀 Chuyển Đổi Phiên Bản PHP

### Sang PHP 7.4
```bash
# Sửa docker-compose.build.yml
# Thay đổI: dockerfile: php.Dockerfile
# Thành:    dockerfile: php7.Dockerfile

# Rebuild
docker-compose -f docker-compose.build.yml up -d --build php
```

---

## 🐛 Xử Lý Lỗi

### Port Đã Được Sử Dụng
```bash
# Kiểm tra gì đang dùng port 8000
lsof -i :8000

# Đổi port trong file docker-compose
ports:
  - "8080:80"
```

### Vấn Đề Quyền Truy Cập (Linux/Mac)
```bash
sudo chown -R $USER:$USER wwwroot/
chmod -R 755 wwwroot/
```

### Database Chưa Sẵn Sàng
```bash
# Đợi health check
docker-compose ps mysql

# Kiểm tra logs
docker-compose logs mysql
```

### Reset Mọi Thứ
```bash
docker-compose down -v
docker-compose up -d
```

---

## 📦 Dành Cho NgườI Phát Triển

Muốn publish images của riêng bạn? Xem **[PUBLISH_GUIDE.md](PUBLISH_GUIDE.md)** để biết:
- Build images local
- Dùng GitHub Actions (auto-build khi push)
- Publish lên Docker Hub

---

## 📚 Tài Liệu Tham Khảo

- [Docker Docs](https://docs.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Nginx Docs](https://nginx.org/en/docs/)
- [PHP Docker](https://hub.docker.com/_/php)
- [MySQL Docker](https://hub.docker.com/_/mysql)

---

## 📄 Giấy Phép

Mã nguồn mở. Tự do sử dụng cho nhu cầu phát triển của bạn.

---

**Chúc Bạn Code Vui! 🚀**
