variable "IMAGE_NAME" {
  default =  "alertmanager"
}

variable "VERSION" {
  default = "0.25.0"
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
    ALERTMANAGER_URL_AMD64 = "https://github.com/prometheus/alertmanager/releases/download/v0.25.0/alertmanager-0.25.0.linux-amd64.tar.gz"
    ALERTMANAGER_SHA256_AMD64 = "206cf787c01921574ca171220bb9b48b043c3ad6e744017030fed586eb48e04b"
    ALERTMANAGER_URL_ARM64 = "https://github.com/prometheus/alertmanager/releases/download/v0.25.0/alertmanager-0.25.0.linux-arm64.tar.gz"
    ALERTMANAGER_SHA256_ARM64 = "20db5e4e12bcce8e2e419cc4c2bc35062ddbc14d2aacb77e4d5684c0eab7f0fe"
    ALERTMANAGER_URL_ARMHF = "https://github.com/prometheus/alertmanager/releases/download/v0.25.0/alertmanager-0.25.0.linux-armv7.tar.gz"
    ALERTMANAGER_SHA256_ARMHF = "3cfd839d4463a7679d32800258b11471498ebc49483273d588818c0432a80af1"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${VERSION}",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "Prometheus Alermanager."
    "org.opencontainers.image.title" = "${IMAGE_NAME}"
    "dev.polymathrobotics.image.readme-filepath" = "prometheus/alertmanager/README.md"
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