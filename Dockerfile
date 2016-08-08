FROM nginx:VERSION

COPY default.conf /etc/nginx/conf.d/default.conf.template

ENV FPM_HOST=app FPM_PORT=9000

CMD envsubst '$$FPM_HOST $$FPM_PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
