# 使用官方的Node.js镜像作为基础镜像
FROM node:14-alpine as builder

# 设置工作目录
WORKDIR /app

# 复制依赖文件
COPY package*.json ./

# 安装生产环境依赖
RUN npm ci --only=production

# 复制应用程序源代码
COPY . .

# 构建生产环境
RUN npm run build

# 使用nginx作为最终的镜像
FROM nginx:alpine

# 移除nginx默认配置文件
RUN rm /etc/nginx/conf.d/default.conf

# 添加我们的静态文件到容器中
COPY --from=builder /app/dist /usr/share/nginx/html

# 添加自定义的nginx配置文件
COPY nginx.conf /etc/nginx/conf.d/