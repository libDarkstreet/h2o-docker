FROM alpine:latest as builder

WORKDIR /h2o

RUN apk update
RUN apk add --no-cache git make cmake ca-certificates openssl clang clang-dev gcc g++ libc-dev linux-headers openssl-dev zlib zlib-dev perl
RUN update-ca-certificates
RUN git clone https://github.com/h2o/h2o.git .

RUN cmake .
RUN make
RUN make install

FROM alpine:latest as prod
WORKDIR /h2o

RUN addgroup h2o \
    && adduser -G h2o -D h2o

RUN apk update
RUN apk add --no-cache ca-certificates openssl openssl-dev perl
RUN chown h2o:h2o /h2o
RUN mkdir /usr/local/share/h2o
COPY --from=builder /h2o/h2o /h2o
COPY --from=builder /usr/local/share/h2o/* /usr/local/share/h2o

CMD /h2o/h2o --conf /config/h2o.conf
