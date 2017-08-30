FROM golang:1.9 as builder
MAINTAINER Travis CI GmbH <support+travis-worker-docker-image@travis-ci.org>

COPY . /go/src/github.com/travis-ci/worker
WORKDIR /go/src/github.com/travis-ci/worker
RUN go get ./...
RUN make build

#################################
### linux/amd64/travis-worker ###
#################################

FROM alpine:latest
RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /go/src/github.com/travis-ci/worker/build/linux/amd64/travis-worker .

CMD ["/root/travis-worker"]
