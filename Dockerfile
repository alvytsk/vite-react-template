FROM node:20-alpine AS base

# Stage 1: Development Stage
FROM base AS develop

WORKDIR /app

# Установка зависимостей
COPY package*.json ./
RUN npm install

# Копируем исходный код
COPY . .

# Устанавливаем переменную окружения
ENV NODE_ENV=development

# Открываем порт
EXPOSE 5173

# Запуск Vite в режиме разработки с поддержкой горячей перезагрузки
CMD ["npm", "run", "dev", "--", "--host"]

# Stage 2: Build Stage
FROM base AS build

WORKDIR /app

# Установка зависимостей
COPY package*.json ./
RUN npm install

# Копирование исходного кода и сборка проекта
COPY . .
RUN npm run build

# Stage 3: Production Stage
FROM nginx:stable-alpine

# Копирование собранных файлов из стадии build
COPY --from=build /app/dist /usr/share/nginx/html

# Открываем порт 80 и запускаем Nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]