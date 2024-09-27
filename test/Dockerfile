FROM registry.cn-hangzhou.aliyuncs.com/watone_docker/xk-node:20 AS base
LABEL xkloveme xkloveme@gmail.com

WORKDIR /app
COPY . .
RUN --mount=type=cache,id=pnpm-store,target=/root/.pnpm-store \
    pnpm install
RUN pnpm build


# 打包生产环境镜像

FROM registry.cn-hangzhou.aliyuncs.com/watone_docker/xk-nginx:latest as production-stage

COPY --from=base /app/dist /usr/share/nginx/html
COPY ./www /etc/nginx/www


#EXPOSE 映射端口
EXPOSE 3000
#ENTRYPOINT 运行以下命令
ENTRYPOINT ["nginx", "-g", "daemon off;"]
