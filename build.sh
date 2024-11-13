#!/bin/sh
registry=xkloveme/xk-node
registryNginx=xkloveme/xk-nginx

# 使用空格分隔的字符串替代数组
NODE_VERSIONS="16 18 20"
OS_TYPES="alpine debian ubuntu"

# 重试函数
retry_command() {
    cmd="$@"
    max_attempts=5
    attempt=1
    delay=15

    while [ $attempt -le $max_attempts ]; do
        echo "尝试执行命令 (${attempt}/${max_attempts})..."
        
        if eval "$cmd"; then
            echo "命令执行成功！"
            return 0
        fi
        
        echo "命令执行失败，等待 ${delay} 秒后重试..."
        attempt=$((attempt + 1))
        sleep $delay
        delay=$((delay * 2))
    done
    
    echo "达到最大重试次数，执行失败"
    return 1
}

# 帮助信息
show_help() {
    echo "使用方法: ./build.sh [选项]"
    echo "选项:"
    echo "  16, 18, 20     - 构建指定 Node.js 版本的镜像"
    echo "  all            - 构建所有 Node.js 版本的镜像"
    echo "  nginx          - 构建 Nginx 镜像"
    echo "  -h, --help     - 显示帮助信息"
}

# 构建并推送镜像
build_and_push() {
    version=$1
    os_type=$2
    tag="${version}-${os_type}"
    manifest_tag="${registry}:${tag}"
    
    echo "正在构建 Node.js ${version} (${os_type}) 镜像..."
    
    # 构建镜像
    retry_command "docker build \
        --build-arg NODE_VERSION=${version} \
        --build-arg OS_TYPE=${os_type} \
        -f ./dockerfile.${version} \
        -t ${manifest_tag} ."
    
    # 推送镜像
    retry_command "docker push ${manifest_tag}"
}

# 构建 Nginx 镜像
build_nginx() {
    echo "正在构建 Nginx 镜像..."
    
    # 构建镜像
    retry_command "docker build \
        -f ./dockerfile.nginx \
        -t ${registryNginx}:latest \
        -t ${registryNginx}:stable-alpine ."
    
    # 推送镜像
    retry_command "docker push ${registryNginx}:latest"
    retry_command "docker push ${registryNginx}:stable-alpine"
}

# 构建所有版本
build_all() {
    for version in $NODE_VERSIONS; do
        for os in $OS_TYPES; do
            build_and_push "$version" "$os"
        done
    done
}

# 检查环境
check_environment() {
    echo "检查环境配置..."
    
    # 检查 Docker
    if ! docker info >/dev/null 2>&1; then
        echo "错误: Docker 未运行"
        exit 1
    fi
    
    # 检查 Docker 登录状态
    echo "检查 Docker 登录状态..."
    if ! docker info 2>/dev/null | grep -q "Username"; then
        # 尝试从配置文件读取凭据
        if [ -f "$HOME/.docker/config.json" ]; then
            echo "找到 Docker 配置文件..."
        else
            echo "错误: Docker 未登录，请先运行："
            echo "docker login"
            exit 1
        fi
    fi
    
    echo "Docker Hub 登录成功"
    echo "环境检查完成"
}

# 主逻辑
check_environment

case "$1" in
    "16"|"18"|"20")
        for os in $OS_TYPES; do
            build_and_push "$1" "$os"
        done
        ;;
    "all")
        build_all
        ;;
    "nginx")
        build_nginx
        ;;
    "-h"|"--help")
        show_help
        ;;
    *)
        echo "错误: 无效的参数"
        show_help
        exit 1
        ;;
esac

exit 0
