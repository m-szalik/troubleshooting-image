# builder image
FROM golang:1.22 as builder
RUN mkdir -p /build/http_server
ADD http_server /build/http_server
WORKDIR /build/http_server
RUN CGO_ENABLED=0 GOOS=linux go build -a -o http_server .

WORKDIR /
RUN go install -v github.com/fullstorydev/grpcurl/cmd/grpcurl@latest


# Final image
FROM ubuntu

RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install --yes dnsutils dnswalk telnet curl iputils-ping net-tools \
 && rm -rf /var/lib/apt/lists/*

EXPOSE 8080

COPY --from=builder /build/http_server/http_server /usr/local/bin/http_server
COPY --from=builder /go/bin/grpcurl /usr/local/bin/grpcurl

CMD "/bin/bash"
