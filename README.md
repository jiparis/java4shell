# Java4Shell detection demo

Shows how Chainloop detects Java4Shell (CVE-2026-114938), the OpenJDK Base64 intrinsic flaw disclosed on 2026-11-17.

- `Dockerfile`: Debian 12 image with the affected `openjdk-17-jre-headless` 17.0.21 package (pinned).
- `.github/workflows/build.yaml`: builds and pushes the image to GHCR, generates a CycloneDX SBOM with syft,
  scans it with grype (SARIF), and sends an attestation to the `java4shell` workflow of the `java4shell`
  project in the `demo` Chainloop organization.
- `.chainloop/contract.yaml`: contract of that workflow. It requires the image, the SBOM and the scan, and
  attaches the built-in `vulnerabilities` policy with a `HIGH` threshold. The `demo` org enforces policies,
  so `chainloop attestation push` fails on the Java4Shell finding.

Grype matches the CVE through the Debian security feed. NVD has no CPE data for it yet, so JDKs that are not
installed from distro packages (for example Eclipse Temurin) do not match yet.

Setup: create a Chainloop API token scoped to the project and store it as the `CHAINLOOP_TOKEN` repository secret.
