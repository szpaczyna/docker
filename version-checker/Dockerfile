#FROM golang:1.13-buster AS build
#COPY . .
#WORKDIR ./cmd/
#RUN GOARCH=arm64 CGO_ENABLED=0 GOOS=linux go build -v -o ./version-checker .

FROM alpine:3.14
RUN apk --no-cache add ca-certificates
COPY ./bin/version-checker-linux /usr/bin/version-checker
ENTRYPOINT ["/usr/bin/version-checker"]
