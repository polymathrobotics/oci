variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/portainer-ce"
}

variable "VERSION" {
  default = "2.21.0"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  dockerfile = "Containerfile"
  args = {
    PORTAINER_VERSION = "${VERSION}"
    PORTAINER_URL_AMD64 = "https://github.com/portainer/portainer/releases/download/2.21.0/portainer-2.21.0-linux-amd64.tar.gz"
    PORTAINER_SHA256_AMD64 = "53970a4b5bb32502ddebd45c033e8dddcd54ca4a3a234198cafc84d8607a0e69"
    PORTAINER_URL_ARM64 = "https://github.com/portainer/portainer/releases/download/2.21.0/portainer-2.21.0-linux-arm64.tar.gz"
    PORTAINER_SHA256_ARM64 = "d42c864d59b5aa7d16c226d88c7311586f05af29df591cef4cf8cc699741cb15"
  }
  tags = [
    "${TAG_PREFIX}:${VERSION}",
    "${TAG_PREFIX}:latest",
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Zlib"
    "org.opencontainers.image.description" = "Portainer Community Edition GUI-based container management platform."
    "org.opencontainers.image.title" = "${TAG_PREFIX}"
    "org.opencontainers.image.created" = "${timestamp()}"
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