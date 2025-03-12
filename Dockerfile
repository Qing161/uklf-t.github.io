# # 使用官方的Node.js镜像作为基础镜像
# FROM node:14-alpine as builder

# # 设置工作目录
# WORKDIR /app

# # 复制依赖文件
# COPY package*.json ./

# # 安装生产环境依赖
# RUN npm ci --only=production

# # 复制应用程序源代码
# COPY . .

# # 构建生产环境
# RUN npm run build

# # 使用nginx作为最终的镜像
# FROM nginx:alpine

# # 移除nginx默认配置文件
# RUN rm /etc/nginx/conf.d/default.conf

# # 添加我们的静态文件到容器中
# COPY --from=builder /app/dist /usr/share/nginx/html

# # 添加自定义的nginx配置文件
# COPY nginx.conf /etc/nginx/conf.d/

# 使用Node镜像作为基础镜像，用于构建Vue项目
FROM node:latest as build-stage

# 设置工作目录
WORKDIR /app

# 将package.json和package-lock.json复制到容器里
COPY package*.json ./

# 安装依赖
RUN npm install

# 复制Vue项目源代码
COPY . .

# 构建Vue项目的生产版本
RUN npm run build

# 使用Nginx镜像作为运行时的基础镜像
FROM nginx:latest

# 删除默认Nginx配置文件
RUN rm /etc/nginx/conf.d/default.conf

# 将Vue项目的生产版本从构建阶段复制过来
COPY --from=build-stage /app/dist/spa /usr/share/nginx/html/医生/网站

# 复制自定义Nginx配置文件（如果有）
COPY nginx.conf /etc/nginx/nginx.conf

# 暴露Nginx的默认HTTP端口（可选）
EXPOSE 80

# 启动Nginx服务
CMD ["nginx", "-g", "daemon off;"]
