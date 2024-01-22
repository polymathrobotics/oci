variable "IMAGE_NAME" {
  default = "grafana-oss"
}

variable "VERSION" {
  default = "10.2.3"
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
  # https://grafana.com/grafana/download?edition=oss
  args = {
    GRAFANA_URL_AMD64 = "https://dl.grafana.com/oss/release/grafana-10.2.3.linux-amd64.tar.gz"
    GRAFANA_SHA256_AMD64 = "c686606a6975481f4f108de44c4df3465251e4ee2da20e7c6ee6b66e5bdcf2da"
    GRAFANA_URL_ARM64 = "https://dl.grafana.com/oss/release/grafana-10.2.3.linux-arm64.tar.gz"
    GRAFANA_SHA256_ARM64 = "7eb36c3dcfe11a72d2aed9784294785ab1894b0314ae595baaf1eb0c701db42a"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${VERSION}",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:latest",
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "AGPLv3"
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
