variable "IMAGE_NAME" {
  default =  "collectd_exporter"
}

variable "VERSION" {
  default = "0.6.0"
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
    COLLECTD_EXPORTER_URL_AMD64 = "https://github.com/prometheus/collectd_exporter/releases/download/v0.6.0/collectd_exporter-0.6.0.linux-amd64.tar.gz"
    COLLECTD_EXPORTER_SHA256_AMD64 = "5e8345299e8d9df682d8032678095d20b1fa4178505389c52e03ed98c83f7ec8"
    COLLECTD_EXPORTER_URL_ARM64 = "https://github.com/prometheus/collectd_exporter/releases/download/v0.6.0/collectd_exporter-0.6.0.linux-arm64.tar.gz"
    COLLECTD_EXPORTER_SHA256_ARM64 = "b0a8ee92474c49511bf833c4fdcbe8f477f85cebd812936c415f292894bdf694"
    COLLECTD_EXPORTER_URL_ARMHF = "https://github.com/prometheus/collectd_exporter/releases/download/v0.6.0/collectd_exporter-0.6.0.linux-armv7.tar.gz"
    COLLECTD_EXPORTER_SHA256_ARMHF = "8d1f169b3ff603cb44a8b0e15ebf0d6c40ad1970eb8a4cc48e690760241a9b24"
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
    "dev.polymathrobotics.image.readme-filepath" = "prometheus/collectd_exporter/README.md"
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
