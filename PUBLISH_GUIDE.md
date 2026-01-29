# 📦 Hướng Dẫn Publish Docker Images / Docker Image Publishing Guide

> 🌏 **Ngôn ngữ/Language**: [Tiếng Việt](#tiếng-việt) | [English](#english)

---

## 🇻🇳 Tiếng Việt

Hướng dẫn này dành cho **ngưới phát triển/maintainer** để build và publish images lên Docker Hub.

### 🔧 Cách 1: Sử Dụng Script (Khuyến Nghị)

```bash
# Cách 1: Truyền username trực tiếp
./build-and-push.sh baocloud 1.0.0

# Cách 2: Export biến môi trường
export DOCKER_USERNAME=baocloud
./build-and-push.sh
```

### 🔧 Cách 2: Sử Dụng GitHub Actions (Tự Động)

#### Bước 1: Thiết Lập Secrets

Vào **Settings → Secrets and variables → Actions** trong repository GitHub, thêm:

| Secret Name | Value |
|-------------|-------|
| `DOCKER_USERNAME` | Tên Docker Hub của bạn |
| `DOCKER_PASSWORD` | Docker Hub Access Token (khuyến nghị) hoặc password |

> 💡 **Tạo Access Token**: [Docker Hub → Account Settings → Security → New Access Token](https://hub.docker.com/settings/security)

#### Bước 2: Kích Hoạt Build

Build sẽ tự động chạy khi:
- Push code lên `main` hoặc `master`
- Tạo tag bắt đầu bằng `v` (ví dụ: `v1.0.0`)
- Chạy thủ công từ tab **Actions** → **Build and Push Docker Images** → **Run workflow**

### 🔧 Cách 3: Build & Push Thủ Công

```bash
# 1. Login Docker Hub
docker login

# 2. Build PHP image
docker build -t baocloud/lemp-php:8.2 -f images/php.Dockerfile images/
docker push baocloud/lemp-php:8.2

# 3. Build Nginx image  
docker build -t baocloud/lemp-nginx:latest -f images/nginx.Dockerfile images/
docker push baocloud/lemp-nginx:latest

# 4. Build MySQL image
docker build -t baocloud/lemp-mysql:8.0 -f images/mysql.Dockerfile images/
docker push baocloud/lemp-mysql:8.0
```

---

## 🇺🇸 English

This guide is for **developers/maintainers** to build and publish images to Docker Hub.

### 🔧 Method 1: Using Script (Recommended)

```bash
# Option 1: Pass username directly
./build-and-push.sh baocloud 1.0.0

# Option 2: Export environment variable
export DOCKER_USERNAME=baocloud
./build-and-push.sh
```

### 🔧 Method 2: Using GitHub Actions (Automatic)

#### Step 1: Setup Secrets

Go to **Settings → Secrets and variables → Actions** in your GitHub repository, add:

| Secret Name | Value |
|-------------|-------|
| `DOCKER_USERNAME` | Your Docker Hub username |
| `DOCKER_PASSWORD` | Docker Hub Access Token (recommended) or password |

> 💡 **Create Access Token**: [Docker Hub → Account Settings → Security → New Access Token](https://hub.docker.com/settings/security)

#### Step 2: Trigger Build

Build will automatically run when:
- Push code to `main` or `master`
- Create tag starting with `v` (e.g., `v1.0.0`)
- Run manually from **Actions** tab → **Build and Push Docker Images** → **Run workflow**

### 🔧 Method 3: Manual Build & Push

```bash
# 1. Login to Docker Hub
docker login

# 2. Build PHP image
docker build -t baocloud/lemp-php:8.2 -f images/php.Dockerfile images/
docker push baocloud/lemp-php:8.2

# 3. Build Nginx image  
docker build -t baocloud/lemp-nginx:latest -f images/nginx.Dockerfile images/
docker push baocloud/lemp-nginx:latest

# 4. Build MySQL image
docker build -t baocloud/lemp-mysql:8.0 -f images/mysql.Dockerfile images/
docker push baocloud/lemp-mysql:8.0
```

---

## 📋 Image Naming Convention / Quy Ước Đặt Tên Image

```
[DOCKER_USERNAME]/lemp-[service]:[version]

Ví dụ/Examples:
  - baocloud/lemp-php:8.2
  - baocloud/lemp-php:latest
  - baocloud/lemp-nginx:latest
  - baocloud/lemp-mysql:8.0
```

---

## ⚠️ Lưu Ý / Notes

- Images sẽ **public** theo mặc định trên Docker Hub
- Nên sử dụng **version tags** thay vì chỉ dùng `latest` để đảm bảo reproducibility
- Có thể sử dụng Docker Hub để tạo **Automated Builds** từ GitHub repository
