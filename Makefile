.PHONY: build
build: build-container
	podman run --rm -v .:/build:Z -w /build \
		-it rsw-proto $(MAKE) ephemeralpeer

.PHONY: ephemeralpeer
ephemeralpeer:
	$(MAKE) PROTO=ephemeralpeer/ephemeralpeer.proto grpc

.PHONY: grpc
grpc:
	protoc --go_out=. --go_opt=paths=source_relative \
		--go-grpc_out=. --go-grpc_opt=paths=source_relative ${PROTO}

.PHONY: build-container
build-container:
	podman build --target grpc -t rsw-proto .
