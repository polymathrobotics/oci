variable "IMAGE_NAME" {
  default = "grafana-oss"
}

variable "VERSION" {
  default = "9.5.1"
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
    GRAFANA_URL_AMD64 = "https://dl.grafana.com/oss/release/grafana-9.5.1.linux-amd64.tar.gz"
    GRAFANA_SHA256_AMD64 = "d9b7505cdd4299c1835c36547ffe2e62d3b0ec7600dca2c644a0519572c9c387"
    GRAFANA_URL_ARM64 = "https://dl.grafana.com/oss/release/grafana-9.5.1.linux-arm64.tar.gz"
    GRAFANA_SHA256_ARM64 = "ed6c692be378e2d9a1a730169867ea4f3da83d814f123a1a340579644032c93e"
    GRAFANA_URL_ARMHF = "https://dl.grafana.com/oss/release/grafana-9.5.1.linux-armv7.tar.gz"
    GRAFANA_SHA256_ARMHF = "29dfd878e78b5810d3bfd2399e5b0a159e38220f9283c44c202299b8e59ab099"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${VERSION}",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:latest",
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "Grafana - the open observability platform."
    "org.opencontainers.image.title" = "${IMAGE_NAME}"
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