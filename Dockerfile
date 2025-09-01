FROM ubuntu:24.04 AS build

ENV GO_FILENAME=go1.23.6.linux-amd64.tar.gz
ENV GO_FILEHASH=9379441ea310de000f33a4dc767bd966e72ab2826270e038e78b2c53c2e7802d
ENV PATH="$PATH:/usr/local/go/bin:/root/go/bin"

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl make git zip \
  && curl -L https://go.dev/dl/${GO_FILENAME} >/tmp/${GO_FILENAME} \
  && echo ${GO_FILEHASH} /tmp/${GO_FILENAME} | sha256sum --check \
  && tar -C /usr/local -xzf /tmp/${GO_FILENAME}

FROM build AS grpc

RUN apt-get install -y --no-install-recommends make unzip \
  && curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v29.3/protoc-29.3-linux-x86_64.zip \
  && unzip protoc-29.3-linux-x86_64.zip -d /usr/local \
  && go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.36.4 \
  && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.5.1
