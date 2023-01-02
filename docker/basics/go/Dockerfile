FROM golang:1.16-alpine

WORKDIR /app

COPY main.go ./

RUN go mod init example/hello

RUN go run main.go