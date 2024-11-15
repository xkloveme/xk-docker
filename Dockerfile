FROM alpine:edge
LABEL xkloveme="xkloveme@gmail.com"
ARG PNPM_VERSION=9.11.0
ENV PNPM_HOME=/root/.local/share/pnpm
ENV PATH=$PATH:$PNPM_HOME
RUN apk update \
    && apk add --no-cache --update curl nodejs npm git \
    && curl -fsSL "https://ghproxy.cc/https://github.com/pnpm/pnpm/releases/download/v${PNPM_VERSION}/pnpm-linuxstatic-x64" -o /bin/pnpm \
    && chmod +x /bin/pnpm \
    && apk del curl \
    && node -v && npm -v && pnpm -v \
    && pnpm config set registry https://registry.npmmirror.com/