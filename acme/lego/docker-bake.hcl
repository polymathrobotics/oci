variable "IMAGE_NAME" {
  default = "lego"
}

variable "VERSION" {
  default = "4.17.4"
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
    LEGO_URL_AMD64 = "https://github.com/go-acme/lego/releases/download/v4.17.4/lego_v4.17.4_linux_amd64.tar.gz"
    LEGO_SHA256_AMD64 = "f362d59ff5b6f92c599e3151dcf7b6ed853de05533be179b306ca40a7b67fb47"
    LEGO_URL_ARM64 = "https://github.com/go-acme/lego/releases/download/v4.17.4/lego_v4.17.4_linux_arm64.tar.gz"
    LEGO_SHA256_ARM64 = "b79c3a2bad15c2359524a3372361377e09c15d0efe6a51223cdccf036d3f6e98"
    LEGO_URL_ARMHF = "https://github.com/go-acme/lego/releases/download/v4.17.4/lego_v4.17.4_linux_armv7.tar.gz"
    LEGO_SHA256_ARMHF = "bb5a8a9cd4176c222656701e61b6420bed03294fc88f48a39dc541c229f0b961"
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
