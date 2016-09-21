FROM nginx:1.11.4

COPY default.conf /etc/nginx/conf.d/default.conf.template

ENV FPM_HOST=app FPM_PORT=9000 UPLOAD_MAX_SIZE=1m

CMD envsubst '$$FPM_HOST $$FPM_PORT $$UPLOAD_MAX_SIZE' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
