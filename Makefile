WHAT := script_exporter
BUILDTIME := $(shell date +%FT%T%Z)
VERSION=`git describe --tags`
COMMIT=`git rev-parse HEAD`
BUILDUSER := $(shell id -un)

.PHONY: build build-darwin-amd64 build-linux-amd64 build-windows-amd64

build:
	for target in $(WHAT); do \
		go build -ldflags "-X github.com/ricoberger/script_exporter/pkg/version.GitCommit=${COMMIT} \
			-X github.com/ricoberger/script_exporter/pkg/version.Version=${VERSION} \
			-X github.com/ricoberger/script_exporter/pkg/version.BuildTime=${BUILDTIME} \
			-X github.com/ricoberger/script_exporter/pkg/version.BuildUser=${BUILDUSER}" \
			-o ./bin/$$target ./cmd/$$target; \
	done

build-darwin-amd64:
	for target in $(WHAT); do \
		CGO_ENABLED=0 GOARCH=amd64 GOOS=darwin go build -a -installsuffix cgo -ldflags "-X github.com/ricoberger/script_exporter/pkg/version.GitCommit=${COMMIT} \
			-X github.com/ricoberger/script_exporter/pkg/version.Version=${VERSION} \
			-X github.com/ricoberger/script_exporter/pkg/version.BuildTime=${BUILDTIME} \
			-X github.com/ricoberger/script_exporter/pkg/version.BuildUser=${BUILDUSER}" \
			-o ./bin/$$target-${VERSION}-darwin-amd64 ./cmd/$$target; \
	done

build-linux-amd64:
	for target in $(WHAT); do \
		CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -a -installsuffix cgo -ldflags "-X github.com/ricoberger/script_exporter/pkg/version.GitCommit=${COMMIT} \
			-X github.com/ricoberger/script_exporter/pkg/version.Version=${VERSION} \
			-X github.com/ricoberger/script_exporter/pkg/version.BuildTime=${BUILDTIME} \
			-X github.com/ricoberger/script_exporter/pkg/version.BuildUser=${BUILDUSER}" \
			-o ./bin/$$target-${VERSION}-linux-amd64 ./cmd/$$target; \
	done

build-windows-amd64:
	for target in $(WHAT); do \
		CGO_ENABLED=0 GOARCH=amd64 GOOS=windows go build -a -installsuffix cgo -ldflags "-X github.com/ricoberger/script_exporter/pkg/version.GitCommit=${COMMIT} \
			-X github.com/ricoberger/script_exporter/pkg/version.Version=${VERSION} \
			-X github.com/ricoberger/script_exporter/pkg/version.BuildTime=${BUILDTIME} \
			-X github.com/ricoberger/script_exporter/pkg/version.BuildUser=${BUILDUSER}" \
			-o ./bin/$$target-${VERSION}-windows-amd64.exe ./cmd/$$target; \
	done