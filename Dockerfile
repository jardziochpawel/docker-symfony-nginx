FROM nginx:1.11.1-alpine

# From PHP container:
# 82 is the standard uid/gid for "www-data" in Alpine
# (nginx in our case)
RUN set -xe \
    && echo "http://nl.alpinelinux.org/alpine/edge/testing" | tee -a /etc/apk/repositories \
    && apk add --no-cache shadow \
    && usermod -u 82 nginx \
    && groupmod -g 82 nginx \
    && apk del --no-cache shadow \
    && head -n -1 /etc/apk/repositories | tee /etc/apk/repositories

COPY default.conf /etc/nginx/conf.d/default.conf.template

ENV FPM_HOST=app FPM_PORT=9000 UPLOAD_MAX_SIZE=1m

CMD envsubst '$$FPM_HOST $$FPM_PORT $$UPLOAD_MAX_SIZE' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
