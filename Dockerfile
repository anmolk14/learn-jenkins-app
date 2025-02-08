FROM nginx:1.27-alpine
# RUN npm install -g serve
COPY build /usr/share/nginx/html