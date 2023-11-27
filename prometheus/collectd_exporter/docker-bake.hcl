variable "IMAGE_NAME" {
  default =  "collectd_exporter"
}

variable "VERSION" {
  default = "0.5.0"
}

variable "CONTAINER_REGISTRY" {
  default = "docker.io/polymathrobotics"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  dockerfile = "Containerfile"
  args = {
    COLLECTD_EXPORTER_URL_AMD64 = "https://github.com/prometheus/collectd_exporter/releases/download/v0.5.0/collectd_exporter-0.5.0.linux-amd64.tar.gz"
    COLLECTD_EXPORTER_SHA256_AMD64 = "5b906b1ea49c119024350c10b4b8491857a20336a0ffd778a3f10d7536a6d123"
    COLLECTD_EXPORTER_URL_ARM64 = "https://github.com/prometheus/collectd_exporter/releases/download/v0.5.0/collectd_exporter-0.5.0.linux-arm64.tar.gz"
    COLLECTD_EXPORTER_SHA256_ARM64 = "eef28573acb3410137640e80787784027858831bfd8502c5c43df4ca6dc34d45"
    COLLECTD_EXPORTER_URL_ARMHF = "https://github.com/prometheus/collectd_exporter/releases/download/v0.5.0/collectd_exporter-0.5.0.linux-armv7.tar.gz"
    COLLECTD_EXPORTER_SHA256_ARMHF = "53cea60cd356f76ac3b67a9f0246ffe4a0c43ea5cca2f0d88f944e32a6494cfd"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${VERSION}",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "A server that accepts collectd stats via HTTP POST and exports them via HTTP for Prometheus consumption."
    "org.opencontainers.image.title" = "${IMAGE_NAME}"
    "dev.polymathrobotics.image.readme-filepath" = "prometheus/collect_exporter/README.md"
  }
}

target "local" {
  inherits = ["_common"]
  platforms = ["${LOCAL_PLATFORM}"]
}

target "default" {
  inherits = ["_common"]
  platforms = ["linux/amd64", "linux/arm64/v8"]
}