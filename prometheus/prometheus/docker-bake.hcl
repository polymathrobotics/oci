variable "IMAGE_NAME" {
  default =  "prometheus"
}

variable "VERSION" {
  default = "2.49.1"
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
    PROMETHEUS_URL_AMD64 = "https://github.com/prometheus/prometheus/releases/download/v2.49.1/prometheus-2.49.1.linux-amd64.tar.gz"
    PROMETHEUS_SHA256_AMD64 = "93460f66d17ee70df899e91db350d9705c20b1576800f96acbd78fa004e7dc07"
    PROMETHEUS_URL_ARM64 = "https://github.com/prometheus/prometheus/releases/download/v2.49.1/prometheus-2.49.1.linux-arm64.tar.gz"
    PROMETHEUS_SHA256_ARM64 = "453c530f17e899999a0ba34b5556b14a14061c22520edaac84b3376d28942664"
    PROMETHEUS_URL_ARMHF = "https://github.com/prometheus/prometheus/releases/download/v2.49.1/prometheus-2.49.1.linux-armv7.tar.gz"
    PROMETHEUS_SHA256_ARMHF = "938f5e8e8bd285501610f73ba5d164222b688ac8308a98da96fa929d69e16272"
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
