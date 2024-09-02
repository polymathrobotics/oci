variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/cinc-auditor"
}

variable "VERSION" {
  default = "6.8.1"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  dockerfile = "Containerfile"
  args = {
    CINC_AUDITOR_URL_AMD64 = "http://ftp.osuosl.org/pub/cinc/files/stable/cinc-auditor/6.8.1/ubuntu/22.04/cinc-auditor_6.8.1-1_amd64.deb"
    CINC_AUDITOR_SHA256_AMD64 = "0d64f9d2a4cfc09d970606200a9bd2f56079c55df14d8019336945a3feb1e377"
    CINC_AUDITOR_URL_ARM64 = "http://ftp.osuosl.org/pub/cinc/files/stable/cinc-auditor/6.8.1/ubuntu/22.04/cinc-auditor_6.8.1-1_arm64.deb"
    CINC_AUDITOR_SHA256_ARM64 = "d5c2af04c9642cdedfb4448c3548af6fff385f9541e6a2f1fa49c998ab0d5244"
  }
  tags = [
    "${TAG_PREFIX}:${VERSION}",
    "${TAG_PREFIX}:latest"
  ]
}

target "local" {
  inherits = ["_common"]
  platforms = ["${LOCAL_PLATFORM}"]
}

target "default" {
  inherits = ["_common"]
  platforms = ["linux/amd64", "linux/arm64/v8"]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci/blob/main/cinc/cinc-auditor/Containerfile"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "Cinc Auditing and Testing Framework."
    "org.opencontainers.image.title" = "${TAG_PREFIX}"
    "org.opencontainers.image.created" = "${timestamp()}"
  }
}
