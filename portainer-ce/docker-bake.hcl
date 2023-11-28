variable "IMAGE_NAME" {
  default = "portainer-ce"
}

variable "VERSION" {
  default = "2.17.1"
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
    PORTAINER_URL_AMD64 = "https://github.com/portainer/portainer/releases/download/2.17.1/portainer-2.17.1-linux-amd64.tar.gz"
    PORTAINER_SHA256_AMD64 = "ec1a1a7e53481b1e4b19f45249fd7398f390d52646ac740d90f254a3b6a5a096"
    PORTAINER_URL_ARM64 = "https://github.com/portainer/portainer/releases/download/2.17.1/portainer-2.17.1-linux-arm64.tar.gz"
    PORTAINER_SHA256_ARM64 = "aaa3841d6e590c5b6820bbe3f2f36f32530e7ce7ef0dd91ee1ce73001c51e2f1"
    PORTAINER_URL_ARMHF = "https://github.com/portainer/portainer/releases/download/2.17.1/portainer-2.17.1-linux-arm.tar.gz"
    PORTAINER_SHA256_ARMHF = "aaa3841d6e590c5b6820bbe3f2f36f32530e7ce7ef0dd91ee1ce73001c51e2f1"
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