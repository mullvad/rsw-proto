# rsw-proto
This repository contains proto files used by public code.

## Update gRPC

Run `make` to update all generated gRPC packages from their respective source
`.proto` files. This will run protoc in a container, using fixed versions for
protoc and related plugins.
