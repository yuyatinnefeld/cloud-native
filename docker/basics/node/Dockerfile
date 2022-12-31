# Stage 1 - Build
FROM node:19-alpine3.16 as appbuild
WORKDIR /app
COPY package.json /app
RUN npm install
COPY src /app/src
RUN npm run build

# Stage 2 - Runtime
FROM node:19-alpine3.16
WORKDIR /app
COPY --from=appbuild app /app
ENV PORT=8080
EXPOSE 8080
CMD [ "npm", "start" ]