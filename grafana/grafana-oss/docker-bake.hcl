variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/grafana-oss"
}

variable "VERSION" {
  default = "11.2.0"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  dockerfile = "Containerfile"
  # https://grafana.com/grafana/download?edition=oss
  args = {
    GRAFANA_URL_AMD64 = "https://dl.grafana.com/oss/release/grafana-11.2.0.linux-amd64.tar.gz"
    GRAFANA_SHA256_AMD64 = "a7e717b78c11e37b147994fc04655da5f434280e1f01ceb84e8f38ca7fdef050"
    GRAFANA_URL_ARM64 = "https://dl.grafana.com/oss/release/grafana-11.2.0.linux-arm64.tar.gz"
    GRAFANA_SHA256_ARM64 = "a0bd569fd4b9130ad1e2507605c11d285de43758bb33cf22114f42bae0fe76ac"
  }
  tags = [
    "${TAG_PREFIX}:${VERSION}",
    "${TAG_PREFIX}:latest",
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "AGPLv3"
    "org.opencontainers.image.description" = "Grafana - the open observability platform."
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
