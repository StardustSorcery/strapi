FROM node:14.21.1-alpine3.16
RUN apk add --no-cache tini
ENTRYPOINT [ "/sbin/tini", "--" ]
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
EXPOSE 1337
WORKDIR /opt/app

RUN apk update &&\
    apk add build-base gcc autoconf automake zlib-dev libpng-dev vips-dev &&\
    rm -rf /var/cache/apk/* > /dev/null 2>&1
COPY ./app/package.json ./app/package-lock.json ./
RUN npm ci
COPY ./app/ .
RUN npm run build
CMD ["npm", "run","develop"]

