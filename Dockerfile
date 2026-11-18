# Debian 12 with the OpenJDK 17 build released before the November 2026 Oracle CPU.
# openjdk-17 17.0.21 is affected by Java4Shell (CVE-2026-114938).
# The version is pinned so the demo keeps working after Debian ships the fix.
FROM debian:bookworm-slim
RUN apt-get update \
 && apt-get install -y --no-install-recommends openjdk-17-jre-headless=17.0.21+9-1~deb12u1 \
 && rm -rf /var/lib/apt/lists/*
ENV JAVA_TOOL_OPTIONS="-XX:-UseBASE64Intrinsics"
CMD ["java", "-version"]
