# syntax=docker/dockerfile:1

FROM node:19-alpine3.16

WORKDIR /app

COPY package.json ./

RUN npm install

COPY src /app/src

ENV PORT=8080

EXPOSE 8080

CMD [ "npm", "start" ]