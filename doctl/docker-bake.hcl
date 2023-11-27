variable "IMAGE_NAME" {
  default =  "doctl"
}

variable "VERSION" {
  default = "1.96.1"
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
    DOCTL_VERSION = "${VERSION}"
    DOCTL_URL_AMD64 = "https://github.com/digitalocean/doctl/releases/download/v1.96.1/doctl-1.96.1-linux-amd64.tar.gz"    
    DOCTL_SHA256_AMD64 = "f19200546b643c292923a4746930d0a42d249d514eaaf29532537e6d1539a1ef"
    DOCTL_URL_ARM64 = "https://github.com/digitalocean/doctl/releases/download/v1.96.1/doctl-1.96.1-linux-arm64.tar.gz"
    DOCTL_SHA256_ARM64 = "8087c734f145af1404068eef1c41f4d2a154080a063f88d296d0b0a84c72ce8b"
  }
  dockerfile = "Containerfile"
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${VERSION}",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "Digital Ocean command-line interface."
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