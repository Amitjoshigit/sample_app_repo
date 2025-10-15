# Build stage
FROM node:18-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN [ -f package-lock.json ] && npm ci || npm install

COPY . .
RUN npm run build

# Runtime
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


