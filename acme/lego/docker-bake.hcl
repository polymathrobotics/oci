variable "IMAGE_NAME" {
  default = "lego"
}

variable "VERSION" {
  default = "4.13.3"
}

variable "CONTAINER_REGISTRY" {
  default = "docker.io/polymathrobotics"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  args = {
    LEGO_URL_AMD64 = "https://github.com/go-acme/lego/releases/download/v4.13.3/lego_v4.13.3_linux_amd64.tar.gz"
    LEGO_SHA256_AMD64 = "d321fc3ee7f33337d8e2c64c6e807a2526c1f1310a40aad3641b06ee60526d95"
    LEGO_URL_ARM64 = "https://github.com/go-acme/lego/releases/download/v4.13.3/lego_v4.13.3_linux_arm64.tar.gz"
    LEGO_SHA256_ARM64 = "787d11f03046285e1e800e8ac19382c05f28d6933236c52fafe025f7cadd9a0b"
    LEGO_URL_ARMHF = "https://github.com/go-acme/lego/releases/download/v4.13.3/lego_v4.13.3_linux_armv7.tar.gz"
    LEGO_SHA256_ARMHF = "4ad6255765052a949f4fc68e24aa34c9ec4f720e4b0f49e968ef682eb5263e70"
  }
  dockerfile = "Containerfile"
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${VERSION}",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/boxcutter/oci"
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