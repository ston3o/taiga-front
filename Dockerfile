FROM nginx:alpine

ENV TAIGA_HOST=taiga.lan SCHEME=http

WORKDIR /srv/taiga

RUN apk --no-cache add git \
	&& rm /etc/nginx/conf.d/default.conf \
	&& mkdir /run/nginx \
	&& git clone --depth=1 -b stable https://github.com/taigaio/taiga-front-dist.git front && cd front \
	&& apk del git \
	&& rm dist/conf.example.json

WORKDIR /srv/taiga/front/dist

COPY start.sh /
COPY nginx.conf /etc/nginx/conf.d/
COPY config.json /tmp/taiga-conf/

VOLUME ["/taiga-conf"]

CMD ["/start.sh"]
