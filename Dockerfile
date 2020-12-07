FROM nginx:1.19.4-alpine
RUN addgroup -S app && adduser -S app -G app
RUN rm /usr/share/nginx/html/index.html
RUN mkdir /usr/share/nginx/html/downloads
# ownloadable content should be mounted to downloads
COPY downloads.conf /etc/nginx/conf.d/downloads.confe
COPY health.html /usr/share/nginx/html/health.html
RUN sed -i 's/listen       80;/listen       8080;/g' /etc/nginx/conf.d/default.conf  && \
  sed -i '/user  nginx;/d' /etc/nginx/nginx.conf && \
  sed -i 's,/var/run/nginx.pid,/tmp/nginx.pid,' /etc/nginx/nginx.conf && \ 
  sed -i "/^http {/a \    server_tokens off;\n    proxy_temp_path /tmp/proxy_temp;\n    client_body_temp_path /tmp/client_temp;\n    fastcgi_temp_path /tmp/fastcgi_temp;\n    uwsgi_temp_path /tmp/uwsgi_temp;\n    scgi_temp_path /tmp/scgi_temp;\n" /etc/nginx/nginx.conf
RUN chown -R app /etc/nginx && chmod -R g+w /etc/nginx && \
  chown -R app /usr/share/nginx && \
  chown -R app /var/cache/nginx && chmod -R g+w /var/cache/nginx
USER app:app