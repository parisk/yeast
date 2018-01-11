FROM ubuntu:16.04 as builder

ARG UNISON_VERSION=2.51.0

RUN apt -y -qq update && \
    apt -y install build-essential software-properties-common opam && \
    eval $(opam config env)

RUN wget https://github.com/bcpierce00/unison/archive/v$UNISON_VERSION.tar.gz && \
    tar -xzvf v$UNISON_VERSION.tar.gz && \
    cd unison-$UNISON_VERSION && \
    make

FROM ubuntu:16.04

ARG UNISON_VERSION=2.51.0

COPY --from=builder /unison-$UNISON_VERSION/src/unison /usr/local/bin
COPY --from=builder /unison-$UNISON_VERSION/src/unison-fsmonitor /usr/local/bin