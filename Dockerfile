FROM golang:1.13-alpine3.10 as build

RUN apk add --no-cache --update git make

RUN mkdir /build
WORKDIR /build
COPY . .
RUN make build


FROM alpine:3.10

LABEL maintainer="Nilay Parikh"
LABEL git.url="https://github.com/nilayparikh/script_exporter"

RUN apk add --no-cache --update curl ca-certificates

USER nobody

COPY --from=build /build/bin/script_exporter /bin/script_exporter
EXPOSE 9469

ENTRYPOINT  [ "/bin/script_exporter", "-config.file=/etc/script_exporter/config.yml" ]
