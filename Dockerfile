FROM nginx:alpine as front

WORKDIR /

# Install certbot and certbot-nginx packages
RUN apk update && apk add certbot certbot-nginx

EXPOSE 80 443

COPY ./conf.d/default.conf /etc/nginx/conf.d/default.conf

