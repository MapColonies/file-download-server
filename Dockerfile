FROM nginx:1-alpine
RUN rm /usr/share/nginx/html/index.html
RUN mkdir /usr/share/nginx/html/downloads
# downloadable content should be mounted to downloads
# mount premissions should be managed externaly
COPY downloads.conf /etc/nginx/conf.d/downloads.conf
COPY health.html /usr/share/nginx/html/health.html

RUN sed -i 's/listen       80;/listen       8080;/g' /etc/nginx/conf.d/default.conf  && \
  sed -i '/user  nginx;/d' /etc/nginx/nginx.conf && \
  sed -i 's,/var/run/nginx.pid,/tmp/nginx.pid,' /etc/nginx/nginx.conf && \ 
  sed -i "/^http {/a \    server_tokens off;\n    proxy_temp_path /tmp/proxy_temp;\n    client_body_temp_path /tmp/client_temp;\n    fastcgi_temp_path /tmp/fastcgi_temp;\n    uwsgi_temp_path /tmp/uwsgi_temp;\n    scgi_temp_path /tmp/scgi_temp;\n" /etc/nginx/nginx.conf
RUN chmod -R +w /var/cache/nginx && chmod +w /etc/nginx/conf.d/default.conf
