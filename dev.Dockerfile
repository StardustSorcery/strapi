FROM node:14.21.1-alpine3.16
RUN apk add --no-cache tini
ENTRYPOINT [ "/sbin/tini", "--" ]
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}
VOLUME /opt/app
WORKDIR /opt/app

RUN apk update &&\
    apk add  build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev
EXPOSE 1337
CMD ["npm", "run", "develop"]

