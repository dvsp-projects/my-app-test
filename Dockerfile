# Stage 1: Build the application
FROM node:20.11 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Nginx Setup
FROM georgjung/nginx-brotli:1.25.3-alpine
RUN apk add gettext
COPY nginx.conf /etc/nginx/templates/nginx.conf.template
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
