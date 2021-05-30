FROM golang:1.16.0-alpine3.12 as builder

WORKDIR /go/src/github.com/eko/pihole-exporter
COPY . .

RUN apk --no-cache add git alpine-sdk ca-certificates 

RUN GO111MODULE=on go mod vendor
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags '-s -w' -o binary ./

FROM alpine
RUN apk --no-cache add ca-certificates

LABEL name="pihole-exporter"

WORKDIR /root/
COPY --from=builder /go/src/github.com/eko/pihole-exporter/binary pihole-exporter

CMD ["./pihole-exporter"]
