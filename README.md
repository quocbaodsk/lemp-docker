# LEMP Docker Development Environment

> 🌏 **Ngôn ngữ/Language**: [English](README.md) | [Tiếng Việt](README_VI.md)

A complete containerized **LEMP stack** (Linux, Nginx, MySQL, PHP) for local web development using Docker Compose. 

🚀 **Zero configuration required** - Get started in seconds with pre-built images!

---

## ✨ Features

- ⚡ **Fast Setup** - Use pre-built images, no local build needed
- 🐘 **PHP 8.2** with common extensions (PDO, GD, ZIP, INTL, etc.)
- 🌐 **Nginx** with gzip compression and security headers
- 🗄️ **MySQL 8.0** with health checks
- 🛠️ **phpMyAdmin** included for database management
- 🔒 **Security** - Best practices applied by default
- 📁 **Volume mounting** - Edit code locally, changes reflect immediately
- 🔄 **Auto-restart** - Containers restart automatically on failure

---

## 📋 Quick Comparison

| Method | Time | Use Case | Command |
|--------|------|----------|---------|
| **Pull Images** ⭐ | ~30 seconds | Quick start, production-like | `docker-compose up -d` |
| **Build Local** | ~3-5 minutes | Development, customize images | `docker-compose -f docker-compose.build.yml up -d --build` |

---

## 🏁 Quick Start

### Option 1: Pull Pre-built Images (Recommended ⭐)

The fastest way to get started. No build required!

```bash
# 1. Clone repository
git clone https://github.com/quocbaodsk/lemp-docker.git
cd lemp-docker

# 2. Set Docker Hub username (replace with actual username)
export DOCKER_USERNAME=baocloud

# 3. Start all services (uses pre-built images)
docker-compose up -d
```

That's it! Your LEMP stack is running. 🎉

### Option 2: Build Images Locally

Build from source if you want to customize the images:

```bash
# 1. Clone repository
git clone https://github.com/quocbaodsk/lemp-docker.git
cd lemp-docker

# 2. (Optional) Edit .env file to customize settings
# vim .env

# 3. Build and start (uses docker-compose.build.yml)
docker-compose -f docker-compose.build.yml up -d --build
```

---

## 🔍 Verify Installation

```bash
# Check container status
docker-compose ps

# View logs
docker-compose logs -f

# Or specific service
docker-compose logs -f php
```

---

## 🌐 Access Your Applications

| URL | Service | Description |
|-----|---------|-------------|
| http://localhost:8000 | **Your App** | Place your PHP files in `wwwroot/` |
| http://localhost:8001 | **phpMyAdmin** | Database management (root/devops123) |

### Test PHP

```bash
# Create a test file
echo "<?php phpinfo(); ?>" > wwwroot/index.php

# Visit http://localhost:8000
```

---

## 📁 Project Structure

```
.
├── config/                     # Configuration files
│   ├── nginx/                 # Nginx configurations
│   │   └── app.conf           # Virtual host configuration
│   └── php-fpm/               # PHP-FPM configurations
│       └── custom.ini         # Custom PHP settings
├── images/                     # Docker build files
│   ├── php.Dockerfile         # PHP 8.2 FPM
│   ├── php7.Dockerfile        # PHP 7.4 (alternative)
│   ├── nginx.Dockerfile       # Nginx
│   └── mysql.Dockerfile       # MySQL 8.0
├── wwwroot/                    # Your PHP application code
├── data/                       # MySQL data persistence
├── logs/                       # Log files
├── docker-compose.yml          # Use pre-built images ⭐ (default)
├── docker-compose.build.yml    # Build locally 🔨 (customize)
├── .env                       # Environment variables
├── build-and-push.sh          # Script to publish images
├── PUBLISH_GUIDE.md           # Maintainer guide
└── README.md                  # This file
```

---

## 🐳 Available Images

| Image | Tag | Size | Pull Command |
|-------|-----|------|--------------|
| `baocloud/lemp-php` | `8.2` | ~150MB | `docker pull baocloud/lemp-php:8.2` |
| `baocloud/lemp-nginx` | `latest` | ~25MB | `docker pull baocloud/lemp-nginx:latest` |
| `baocloud/lemp-mysql` | `8.0` | ~400MB | `docker pull baocloud/lemp-mysql:8.0` |

> 💡 Replace `yourname` with the actual Docker Hub username

---

## 🛠️ PHP Extensions Included

```
✓ pdo, pdo_mysql, mysqli    # Database connectivity
✓ gd                        # Image manipulation
✓ zip                       # Archive handling
✓ intl                      # Internationalization
✓ bcmath                    # Mathematical functions
✓ mbstring                  # Multi-byte strings
✓ Composer                  # Dependency manager
```

---

## 🗄️ Database Connection

### From Host (External)
```
Host:     localhost
Port:     3036
Username: root
Password: devops123
Database: app_db
```

### From PHP (Internal)
```php
<?php
$host = 'mysql';  // Use service name as host
$db   = 'app_db';
$user = 'root';
$pass = 'devops123';

$pdo = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
```

---

## ⚙️ Common Commands

### Lifecycle Management
```bash
# Start services
docker-compose -f docker-compose.pull.yml up -d

# Stop services
docker-compose -f docker-compose.pull.yml down

# Restart specific service
docker-compose restart nginx

# View logs
docker-compose logs -f

# Stop and remove all data (⚠️ deletes database)
docker-compose down -v
```

### Working Inside Containers
```bash
# Run PHP script
docker-compose exec php php script.php

# Run Composer
docker-compose exec php composer install

# MySQL CLI
docker-compose exec mysql mysql -u root -p

# Access shell
docker-compose exec php sh
docker-compose exec nginx sh
```

---

## 🔒 Security Features

- **Security Headers**
  - `X-Frame-Options: SAMEORIGIN`
  - `X-XSS-Protection: 1; mode=block`
  - `X-Content-Type-Options: nosniff`
  - `expose_php = Off`

- **Access Control**
  - Hidden files denied (`.htaccess`, `.env`, etc.)
  - PHP execution restricted

- **Health Checks** - All services monitored

---

## 📝 Configuration

### PHP Settings (`config/php-fpm/custom.ini`)

| Setting | Value | Description |
|---------|-------|-------------|
| `memory_limit` | 512M | Script memory limit |
| `max_execution_time` | 300 | Timeout (seconds) |
| `upload_max_filesize` | 512M | Max upload size |
| `post_max_size` | 512M | Max POST size |
| `max_input_vars` | 3000 | Input variable limit |

### Environment Variables (`.env`)

```env
MYSQL_ROOT_PASSWORD=devops123
MYSQL_DATABASE=app_db
MYSQL_USER=myuser
MYSQL_PASSWORD=password
TZ=Asia/Ho_Chi_Minh
```

---

## 🔀 Switch PHP Version

### To PHP 7.4
```bash
# Edit docker-compose.build.yml
# Change: dockerfile: php.Dockerfile
# To:     dockerfile: php7.Dockerfile

# Rebuild
docker-compose -f docker-compose.build.yml up -d --build php
```

---

## 🐛 Troubleshooting

### Port Already in Use
```bash
# Check what's using port 8000
lsof -i :8000

# Change port in docker-compose file
ports:
  - "8080:80"
```

### Permission Issues (Linux/Mac)
```bash
sudo chown -R $USER:$USER wwwroot/
chmod -R 755 wwwroot/
```

### Database Not Ready
```bash
# Wait for health check
docker-compose ps mysql

# Check logs
docker-compose logs mysql
```

### Reset Everything
```bash
docker-compose down -v
docker-compose up -d
```

---

## 📦 For Maintainers

Want to publish your own images? See **[PUBLISH_GUIDE.md](PUBLISH_GUIDE.md)** for:
- Building images locally
- Using GitHub Actions (auto-build on push)
- Publishing to Docker Hub

---

## 📚 Resources

- [Docker Docs](https://docs.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Nginx Docs](https://nginx.org/en/docs/)
- [PHP Docker](https://hub.docker.com/_/php)
- [MySQL Docker](https://hub.docker.com/_/mysql)

---

## 📄 License

Open source. Use freely for your development needs.

---

**Happy Coding! 🚀**
