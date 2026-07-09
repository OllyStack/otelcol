# Distroless, non-root image for the managed collector — self-building.
# Stage 1 compiles the curated distribution with OCB (so the binary matches the build
# platform's OS/arch — no stale host binary), stage 2 is a minimal runtime.
#
#   docker build -t managed-otelcol:0.155.0 .   (context = this repo root)
#
# Pins: otelcol_version is passed as a build-arg (must match manifest.yaml's otelcol_version).
# Go 1.26.5 REQUIRED: filterprocessor hits a generics linker bug on go 1.23–1.25 (fixed in 1.26), and
# 1.26.5 also patches GO-2026-5856 (crypto/tls ECH leak) — the release workflow's govulncheck enforces
# this. Building on golang:1.25 fails to link; on 1.26.4 fails the vuln scan.

FROM golang:1.26.5-bookworm AS build
ARG OTELCOL_VERSION=0.155.0
ENV CGO_ENABLED=0
WORKDIR /src
RUN go install go.opentelemetry.io/collector/cmd/builder@v${OTELCOL_VERSION}
COPY manifest.yaml /src/manifest.yaml
# Builds the co-tested superset into /src/_build/managed-otelcol (per manifest output_path).
RUN builder --config /src/manifest.yaml

FROM gcr.io/distroless/static-debian12:nonroot
# OTLP gRPC / HTTP, health_check
EXPOSE 4317 4318 13133
COPY --from=build /src/_build/managed-otelcol /usr/bin/managed-otelcol
USER 65532:65532
ENTRYPOINT ["/usr/bin/managed-otelcol"]
CMD ["--config", "/etc/otelcol/config.yaml"]
