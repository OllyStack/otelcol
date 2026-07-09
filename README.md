# OllyStack managed collector (`ghcr.io/ollystack/otelcol`)

The **curated, hardened** OpenTelemetry Collector distribution behind OllyStack's managed fleets — an
[OCB](https://opentelemetry.io/docs/collector/custom-collector/) build that contains **only the
components the portal offers** (`manifest.yaml`), not all of `-contrib`. Same upstream components,
same OTLP, same config — a much smaller dependency tree, so a smaller attack surface and fewer CVEs.

It's the **opt-in** tier: upstream `otel/opentelemetry-collector-contrib` stays the flexible default
(any contrib component works instantly); this is `distro: managed` for security-conscious/regulated
fleets that want a minimal, signed, vuln-scanned collector with nothing they don't use.

## Image

```
ghcr.io/ollystack/otelcol:<collector-version>    # linux/amd64, linux/arm64
```

Every image is built with a pinned patched Go toolchain, **govulncheck**-scanned (blocking), and
published **signed** (keyless cosign), with a **SLSA build-provenance** attestation and an **SBOM**.

## What's here

| File | What |
| --- | --- |
| `manifest.yaml` | the OCB builder manifest — the exact component set (vendored from the portal catalog on each collector bump). Just upstream OTel gomod paths; no secrets. |
| `versions/<ver>/manifest.yaml` | per-version snapshots, so any published version is rebuildable (the manifest is version-locked). |
| `Dockerfile` | self-building: stage 1 runs OCB → binary; stage 2 is distroless/non-root. |
| `.github/workflows/release.yml` | build → scan → sign → attest → SBOM → push. |

## Building / publishing

Actions → **release** → *Run workflow* (empty = current `manifest.yaml`; or enter a snapshotted
version to rebuild it). It pushes `ghcr.io/ollystack/otelcol:<ver>` and prints the digest to record.

## Verifying an image

```sh
IMG=ghcr.io/ollystack/otelcol:0.155.0
# provenance (who/what/where built it)
gh attestation verify oci://$IMG --owner OllyStack
# keyless signature (Sigstore)
cosign verify $IMG \
  --certificate-identity-regexp 'https://github.com/OllyStack/otelcol/.github/workflows/release.yml@.*' \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com
```

> The **component set** (what this build can run) is `manifest.yaml`; the **pipeline config** (what a
> given fleet runs) is delivered separately by the portal (GitOps / OpAMP). Design once, run anywhere.
