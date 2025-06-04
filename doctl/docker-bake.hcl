variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/doctl"
}

variable "VERSION" {
  default = "1.124.0"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  args = {
    DOCTL_VERSION = "${VERSION}"
    DOCTL_URL_AMD64 = "https://github.com/digitalocean/doctl/releases/download/v1.124.0/doctl-1.124.0-linux-amd64.tar.gz"    
    DOCTL_SHA256_AMD64 = "e197811abae90bf44cb4139863471c2c69d0643a2f0d1c28047f369cbf5979e0"
    DOCTL_URL_ARM64 = "https://github.com/digitalocean/doctl/releases/download/v1.124.0/doctl-1.124.0-linux-arm64.tar.gz"
    DOCTL_SHA256_ARM64 = "18d1d8e2327abf1edd114ec0fb78e216bc2e4c2aff197d746fc029d9c3603be7"
  }
  dockerfile = "Containerfile"
  tags = [
    "${TAG_PREFIX}:${VERSION}",
    "${TAG_PREFIX}:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "Digital Ocean command-line interface."
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