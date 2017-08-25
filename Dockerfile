FROM golang:1.9
MAINTAINER Travis CI GmbH <support+travis-worker-docker-image@travis-ci.org>

RUN go get -u \
    github.com/alecthomas/gometalinter \
    github.com/FiloSottile/gvt \
    mvdan.cc/sh/cmd/shfmt
RUN gometalinter --install
RUN apt-get update && apt-get install -y shellcheck

COPY . /go/src/github.com/travis-ci/worker
WORKDIR /go/src/github.com/travis-ci/worker
RUN go get ./...
RUN make
CMD ["travis-worker"]
