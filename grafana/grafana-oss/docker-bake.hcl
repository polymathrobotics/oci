variable "IMAGE_NAME" {
  default = "grafana-oss"
}

variable "VERSION" {
  default = "11.1.3"
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
    GRAFANA_URL_AMD64 = "https://dl.grafana.com/oss/release/grafana-11.1.3.linux-amd64.tar.gz"
    GRAFANA_SHA256_AMD64 = "6cce7ca9554cd5bcfe33e7c9292536d21575dbdd1a0c0de195aaac12a0ed3c9d"
    GRAFANA_URL_ARM64 = "https://dl.grafana.com/oss/release/grafana-11.1.3.linux-arm64.tar.gz"
    GRAFANA_SHA256_ARM64 = "5a3e86d7f070969750b879ea9e984c6aa976cb01bf82de032686ae3b17acbbc4"
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
