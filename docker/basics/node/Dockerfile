# Stage 1
FROM node:19-alpine3.16 as appbuild
WORKDIR /app
COPY package.json ./
RUN npm install
COPY src /app/src

# Stage 2
FROM node:19-alpine3.16
WORKDIR /app
COPY --from=appbuild app ./
ENV PORT=8080
EXPOSE 8080
CMD [ "npm", "start" ]