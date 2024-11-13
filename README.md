# xk-node

## 公司专用打包镜像

> aliyun 镜像源
docker pull registry.cn-hangzhou.aliyuncs.com/watone_docker/xk-node:[镜像版本号]
docker pull registry.cn-hangzhou.aliyuncs.com/watone_docker/xk-nginx:latest

## V16

```sh
docker pull xkloveme/xk-node:16
```

```sh
/ # node -v
v16.20.2
/ # npm -v
8.1.3
/ # pnpm -v
9.11.0
```

## V18

```sh
docker pull xkloveme/xk-node:18
```

```sh
/ # node -v
v18.19.1
/ # npm -v
9.6.6
/ # pnpm -v
9.11.0
```

## V20

```sh
docker pull xkloveme/xk-node:20
```

```sh
/ # node -v
v20.11.1
/ # npm -v
10.4.0
/ # pnpm -v
9.11.0
```

## nginx

```sh
docker pull xkloveme/xk-nginx:latest
```

```sh
/ # nginx -v
nginx version: nginx/1.26.2
```

## 版本标签说明

### Node.js 镜像
- `16-alpine`: Node.js 16 版本
- `18-alpine`: Node.js 18 版本
- `20-alpine`: Node.js 20 版本
- `latest`: 最新版本（指向 Node.js 20）

### Nginx 镜像
- `latest`: 最新版本
- `stable-alpine`: 稳定版本

## 贡献指南

1. Fork 本仓库
2. 创建特性分支：`git checkout -b feature/AmazingFeature`
3. 提交改动：`git commit -m 'Add some AmazingFeature'`
4. 推送分支：`git push origin feature/AmazingFeature`
5. 提交 Pull Request

## 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 联系方式

- 作者：xkloveme
- 邮箱：xkloveme@gmail.com
- 项目链接：[https://github.com/xkloveme/xk-docker](https://github.com/xkloveme/xk-docker)

## 更新日志

### [1.0.0] - 2024-03-17
- 初始版本发布
- 支持 Node.js 16、18、20 版本
- 支持 Nginx 镜像构建
- 添加多架构支持