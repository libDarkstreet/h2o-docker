FROM alpine:3.14 as builder

ARG VER

WORKDIR /h2o

RUN apk update
RUN apk add --no-cache git libstdc++ build-base ruby ruby-dev bison make cmake ca-certificates openssl-dev libc-dev linux-headers zlib-dev ruby-rake perl-dev
RUN update-ca-certificates

RUN git clone --depth 1 --branch $VER https://github.com/h2o/h2o.git .

RUN cmake -DWITH_MRUBY=on -DWITH_BUNDLED_SSL=on

RUN make -j 4 install

FROM alpine:3.14 as prod
WORKDIR /h2o

RUN addgroup h2o && adduser -G h2o -D h2o

RUN apk update
RUN apk add --no-cache ca-certificates openssl perl
RUN chown h2o:h2o /h2o
COPY ./h2o.conf /config/
COPY --from=builder /h2o/h2o /h2o
COPY --from=builder /usr/local/share/h2o /usr/local/share/h2o

CMD /h2o/h2o --conf /config/h2o.conf
