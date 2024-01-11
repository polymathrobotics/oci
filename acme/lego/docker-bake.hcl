variable "IMAGE_NAME" {
  default = "lego"
}

variable "VERSION" {
  default = "4.14.2"
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
    LEGO_URL_AMD64 = "https://github.com/go-acme/lego/releases/download/v4.14.2/lego_v4.14.2_linux_amd64.tar.gz"
    LEGO_SHA256_AMD64 = "f5a978397802a2eb20771925ceb173dff88705b45fdbb2e68312269e205fa85d"
    LEGO_URL_ARM64 = "https://github.com/go-acme/lego/releases/download/v4.14.2/lego_v4.14.2_linux_arm64.tar.gz"
    LEGO_SHA256_ARM64 = "5050df1fb75085122cd253a3877e0d7ea07c4547964378a8f4753e1e2679cce6"
    LEGO_URL_ARMHF = "https://github.com/go-acme/lego/releases/download/v4.14.2/lego_v4.14.2_linux_armv7.tar.gz"
    LEGO_SHA256_ARMHF = "ddbef0a377e9dc37617584eda676ad195d126462673774a181f1374d7f9042a0"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${VERSION}",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "Let's Encrypt/ACME client and library written in Go."
    "org.opencontainers.image.title" = "${IMAGE_NAME}"
    "dev.polymathrobotics.image.readme-filepath" = "acme/lego/README.md"
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
