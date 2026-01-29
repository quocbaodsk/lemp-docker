#!/bin/bash

# Script build và push Docker images lên Docker Hub
# Usage: ./build-and-push.sh [DOCKER_USERNAME] [VERSION]

set -e

# Màu sắc cho output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Lấy thông tin từ arguments hoặc môi trường
DOCKER_USERNAME=${1:-${DOCKER_USERNAME:-""}}
VERSION=${2:-"latest"}

# Kiểm tra Docker username
if [ -z "$DOCKER_USERNAME" ]; then
    echo -e "${RED}❌ Lỗi: Vui lòng cung cấp DOCKER_USERNAME${NC}"
    echo "Usage: ./build-and-push.sh <docker_username> [version]"
    echo "   hoặc: export DOCKER_USERNAME=yourname && ./build-and-push.sh"
    exit 1
fi

# Kiểm tra đã login Docker chưa
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}❌ Lỗi: Docker daemon không chạy hoặc bạn chưa login${NC}"
    echo "Vui lòng chạy: docker login"
    exit 1
fi

echo -e "${BLUE}🚀 Bắt đầu build và push images...${NC}"
echo -e "${BLUE}   Docker Username: $DOCKER_USERNAME${NC}"
echo -e "${BLUE}   Version: $VERSION${NC}"
echo ""

# Build PHP image
echo -e "${YELLOW}📦 Building PHP 8.2 image...${NC}"
docker build -t $DOCKER_USERNAME/lemp-php:8.2 \
             -t $DOCKER_USERNAME/lemp-php:$VERSION \
             -f images/php.Dockerfile images/
echo -e "${GREEN}✅ Build PHP hoàn tất${NC}"
echo ""

# Build Nginx image
echo -e "${YELLOW}📦 Building Nginx image...${NC}"
docker build -t $DOCKER_USERNAME/lemp-nginx:latest \
             -t $DOCKER_USERNAME/lemp-nginx:$VERSION \
             -f images/nginx.Dockerfile images/
echo -e "${GREEN}✅ Build Nginx hoàn tất${NC}"
echo ""

# Build MySQL image
echo -e "${YELLOW}📦 Building MySQL 8.0 image...${NC}"
docker build -t $DOCKER_USERNAME/lemp-mysql:8.0 \
             -t $DOCKER_USERNAME/lemp-mysql:$VERSION \
             -f images/mysql.Dockerfile images/
echo -e "${GREEN}✅ Build MySQL hoàn tất${NC}"
echo ""

# Push images
echo -e "${YELLOW}📤 Pushing images lên Docker Hub...${NC}"
echo ""

echo -e "${BLUE}⬆️  Pushing PHP images...${NC}"
docker push $DOCKER_USERNAME/lemp-php:8.2
docker push $DOCKER_USERNAME/lemp-php:$VERSION
echo -e "${GREEN}✅ Push PHP hoàn tất${NC}"
echo ""

echo -e "${BLUE}⬆️  Pushing Nginx images...${NC}"
docker push $DOCKER_USERNAME/lemp-nginx:latest
docker push $DOCKER_USERNAME/lemp-nginx:$VERSION
echo -e "${GREEN}✅ Push Nginx hoàn tất${NC}"
echo ""

echo -e "${BLUE}⬆️  Pushing MySQL images...${NC}"
docker push $DOCKER_USERNAME/lemp-mysql:8.0
docker push $DOCKER_USERNAME/lemp-mysql:$VERSION
echo -e "${GREEN}✅ Push MySQL hoàn tất${NC}"
echo ""

# Hiển thị thông tin
echo -e "${GREEN}🎉 Hoàn tất! Images đã được push lên Docker Hub.${NC}"
echo ""
echo -e "${BLUE}📋 Các images có sẵn:${NC}"
echo "  ➤ $DOCKER_USERNAME/lemp-php:8.2"
echo "  ➤ $DOCKER_USERNAME/lemp-php:$VERSION"
echo "  ➤ $DOCKER_USERNAME/lemp-nginx:latest"
echo "  ➤ $DOCKER_USERNAME/lemp-nginx:$VERSION"
echo "  ➤ $DOCKER_USERNAME/lemp-mysql:8.0"
echo "  ➤ $DOCKER_USERNAME/lemp-mysql:$VERSION"
echo ""
echo -e "${YELLOW}💡 NgườI dùng có thể pull về bằng lệnh:${NC}"
echo "  docker pull $DOCKER_USERNAME/lemp-php:8.2"
echo "  docker pull $DOCKER_USERNAME/lemp-nginx:latest"
echo "  docker pull $DOCKER_USERNAME/lemp-mysql:8.0"
echo ""
echo -e "${YELLOW}🚀 Hoặc chạy trực tiếp với docker-compose:${NC}"
echo "  export DOCKER_USERNAME=$DOCKER_USERNAME"
echo "  docker-compose -f docker-compose.pull.yml up -d"
