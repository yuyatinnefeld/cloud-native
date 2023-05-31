FROM golang:1.17.5 AS GO_BUILD
ENV CGO_ENABLED 0
WORKDIR /go-app
COPY . /go-app
RUN go mod init go-app
RUN go mod tidy -go=1.16 && go mod tidy -go=1.17
RUN go build -o server

FROM alpine:3.15
WORKDIR /go-app
RUN apk --no-cache add ca-certificates
COPY --from=GO_BUILD /go-app/server /go-app/server
EXPOSE 8080
CMD ["./server"]