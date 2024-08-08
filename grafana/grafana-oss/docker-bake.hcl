variable "IMAGE_NAME" {
  default = "grafana-oss"
}

variable "VERSION" {
  default = "10.4.6"
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
    GRAFANA_URL_AMD64 = "https://dl.grafana.com/oss/release/grafana-10.4.6.linux-amd64.tar.gz"
    GRAFANA_SHA256_AMD64 = "9c68d16eb1b817ed1cee769f6acb475baf14148fd385b3cf6e371f7a9f1464d3"
    GRAFANA_URL_ARM64 = "https://dl.grafana.com/oss/release/grafana-10.4.6.linux-arm64.tar.gz"
    GRAFANA_SHA256_ARM64 = "3ccdba6c9cd157d8028daf1858c7ca72a79e80f89b820ebbe191902badcbbced"
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
