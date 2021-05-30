FROM golang as builder

COPY . /app
WORKDIR /app

#RUN CGO_ENABLED=0 GOARCH=arm64 GOOS=linux go build -a -installsuffix cgo -o mongodb_exporter .
RUN make init &&\
    make format
RUN make build

FROM alpine:latest
RUN apk --no-cache add ca-certificates bash
WORKDIR /bin
COPY --from=builder ./app/mongodb_exporter /bin/mongodb_exporter
CMD /bin/mongodb_exporter 
EXPOSE 9216
