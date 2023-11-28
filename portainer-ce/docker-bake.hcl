variable "IMAGE_NAME" {
  default = "portainer-ce"
}

variable "VERSION" {
  default = "2.19.3"
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
    PORTAINER_VERSION = "${VERSION}"
    PORTAINER_URL_AMD64 = "https://github.com/portainer/portainer/releases/download/2.19.3/portainer-2.19.3-linux-amd64.tar.gz"
    PORTAINER_SHA256_AMD64 = "e75428a96a1cfeff6cec86ab941124b2d62a2dccf4e70924e3f4b65a0b19d119"
    PORTAINER_URL_ARM64 = "https://github.com/portainer/portainer/releases/download/2.19.3/portainer-2.19.3-linux-arm64.tar.gz"
    PORTAINER_SHA256_ARM64 = "fc679e61d45844aa03118fd0bb244f10fd5ba894e3956b837b67562e6a5dd2e4"
    PORTAINER_URL_ARMHF = "https://github.com/portainer/portainer/releases/download/2.19.3/portainer-2.19.3-linux-arm.tar.gz"
    PORTAINER_SHA256_ARMHF = "41b6c457117fd6d83279c31896877368858b6d5c0743a7a8898baa277269d51f"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${VERSION}",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:latest",
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Zlib"
    "org.opencontainers.image.description" = "Portainer Community Edition GUI-based container management platform."
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