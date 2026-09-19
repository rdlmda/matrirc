FROM rust:1.81-alpine3.20 AS builder

RUN apk add --no-cache build-base pkgconf openssl-dev ca-certificates sqlite-dev openssl-libs-static sqlite-dev sqlite-static

WORKDIR /src
COPY . .
RUN cargo build --release

FROM alpine:3.20
RUN apk add --no-cache ca-certificates openssl
COPY --from=builder /src/target/release/matrirc /usr/local/bin/matrirc
EXPOSE 6667
ENTRYPOINT ["matrirc"]
