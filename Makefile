.PHONY: all
all:

.PHONY: ephemeralpeer
ephemeralpeer:
	$(MAKE) PROTO=ephemeralpeer/ephemeralpeer.proto grpc

.PHONY: grpc
grpc:
	protoc --go_out=. --go_opt=paths=source_relative \
		--go-grpc_out=. --go-grpc_opt=paths=source_relative ${PROTO}
