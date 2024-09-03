variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/doctl"
}

variable "VERSION" {
  default = "1.111.0"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  args = {
    DOCTL_VERSION = "${VERSION}"
    DOCTL_URL_AMD64 = "https://github.com/digitalocean/doctl/releases/download/v1.111.0/doctl-1.111.0-linux-amd64.tar.gz"    
    DOCTL_SHA256_AMD64 = "85abc391224c192cd351c16cde2e7092607650089de3f3aa4f2571d7074bdee6"
    DOCTL_URL_ARM64 = "https://github.com/digitalocean/doctl/releases/download/v1.111.0/doctl-1.111.0-linux-arm64.tar.gz"
    DOCTL_SHA256_ARM64 = "311ba00493cf2547c33b9564fe394e05ea04a6176967bff776f6d46b36923bcf"
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