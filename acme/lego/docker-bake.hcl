variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/lego"
}

variable "VERSION" {
  default = "4.18.0"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  dockerfile = "Containerfile"
  args = {
    LEGO_URL_AMD64 = "https://github.com/go-acme/lego/releases/download/v4.18.0/lego_v4.18.0_linux_amd64.tar.gz"
    LEGO_SHA256_AMD64 = "6f42e9ac93cd604951c0cf94a7c4a26ac98251741523ce67eea86ad72c77e6e5"
    LEGO_URL_ARM64 = "https://github.com/go-acme/lego/releases/download/v4.18.0/lego_v4.18.0_linux_arm64.tar.gz"
    LEGO_SHA256_ARM64 = "da12a3a88d14ed4b3ce3bd56e61c821fe5020cb97224b10e1e9aac4da00ebbe7"
  }
  tags = [
    "${TAG_PREFIX}:${VERSION}",
    "${TAG_PREFIX}:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "Let's Encrypt/ACME client and library written in Go."
    "org.opencontainers.image.title" = "${TAG_PREFIX}"
    "org.opencontainers.image.created" = "${timestamp()}"
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
