FROM nginx:1.19.4-alpine
RUN mkdir /usr/share/nginx/html/downloads
# ownloadable content should be mounted to downloads
COPY downloads.conf /etc/nginx/conf.d/downloads.conf
COPY health.html /usr/share/nginx/html/health.html
