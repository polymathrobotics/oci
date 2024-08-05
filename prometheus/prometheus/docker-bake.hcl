variable "IMAGE_NAME" {
  default =  "prometheus"
}

variable "VERSION" {
  default = "2.53.1"
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
    PROMETHEUS_URL_AMD64 = "https://github.com/prometheus/prometheus/releases/download/v2.53.1/prometheus-2.53.1.linux-amd64.tar.gz"
    PROMETHEUS_SHA256_AMD64 = "2234aa0f66d9f9b854144f6faaaed72a316df7a680d9dad7cb48e49a6fa5332c"
    PROMETHEUS_URL_ARM64 = "https://github.com/prometheus/prometheus/releases/download/v2.53.1/prometheus-2.53.1.linux-arm64.tar.gz"
    PROMETHEUS_SHA256_ARM64 = "a7f28c83c3c943b953a9d00860bd3f2422464fb7c27a3c4037ef1ce2a41592b5"
    PROMETHEUS_URL_ARMHF = "https://github.com/prometheus/prometheus/releases/download/v2.53.1/prometheus-2.53.1.linux-armv7.tar.gz"
    PROMETHEUS_SHA256_ARMHF = "d30210c364455730a85ea4109747462f22631c67d7fec6437327cee9766845d8"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${VERSION}",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "Prometheus monitoring system and time series database."
    "org.opencontainers.image.title" = "${IMAGE_NAME}"
    "dev.polymathrobotics.image.readme-filepath" = "prometheus/prometheus/README.md"
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
