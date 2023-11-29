variable "IMAGE_NAME" {
  default = "grafana-oss"
}

variable "VERSION" {
  default = "10.2.2"
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
    GRAFANA_URL_AMD64 = "https://dl.grafana.com/oss/release/grafana-10.2.2.linux-amd64.tar.gz"
    GRAFANA_SHA256_AMD64 = "32dd2c8b94f1917190a79be6543dfb7e5dd6297bae21c24db624dc1180aba19f"
    GRAFANA_URL_ARM64 = "https://dl.grafana.com/oss/release/grafana-10.2.2.linux-arm64.tar.gz"
    GRAFANA_SHA256_ARM64 = "96770f3f9bdfc662e0dbe57fbbb09206817935bca0e38755f942e0f65259e8c7"
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