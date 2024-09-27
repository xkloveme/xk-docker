#!/bin/bash
registry=xkloveme/xk-node
registryNginx=xkloveme/xk-nginx

case "$1" in
16)
  docker build -f ./Dockerfile.16 -t ${registry}:16 .
  docker push ${registry}:16
  ;;
18)
  docker build -f ./Dockerfile.18 -t ${registry}:18 .
  docker push ${registry}:18
  ;;
20)
  docker build -t ${registry}:20 .
  docker tag ${registry}:20 ${registry}:latest
  docker push ${registry}:20
  ;;
nginx)
  docker build  -f ./Dockerfile.nginx  -t ${registryNginx}:latest .
  docker tag ${registryNginx}:latest ${registryNginx}:stable-alpine
  docker push ${registryNginx}:latest
  ;;
esac

exit 0

# docker run -it --name myalpine xkloveme/xk-node:${BUILD_VERSION}
