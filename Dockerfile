# builder image
FROM golang:1.13-alpine3.11 as builder
RUN mkdir /build
ADD *.go /build/
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux go build -a -o http_server .


# Final image
FROM ubuntu

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install --yes dnsutils dnswalk telnet curl iputils-ping net-tools \
 && rm -rf /var/lib/apt/lists/*

EXPOSE 8080

COPY --from=builder /build/http_server /bin/http_server
CMD "/bin/http_server"