variable "TAG_PREFIX" {
  default =  "docker.io/polymathrobotics/pulumi-python"
}

variable "VERSION" {
  default =  "3.130.0"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  args = {
    PULUMI_VERSION = "${VERSION}"
    CINC_AUDITOR_URL_AMD64 = "http://ftp.osuosl.org/pub/cinc/files/stable/cinc-auditor/6.8.1/ubuntu/22.04/cinc-auditor_6.8.1-1_amd64.deb"
    CINC_AUDITOR_SHA256_AMD64 = "0d64f9d2a4cfc09d970606200a9bd2f56079c55df14d8019336945a3feb1e377"
    CINC_AUDITOR_URL_ARM64 = "http://ftp.osuosl.org/pub/cinc/files/stable/cinc-auditor/6.8.1/ubuntu/22.04/cinc-auditor_6.8.1-1_arm64.deb"
    CINC_AUDITOR_SHA256_ARM64 = "d5c2af04c9642cdedfb4448c3548af6fff385f9541e6a2f1fa49c998ab0d5244"
  }
  dockerfile = "Containerfile"
  tags = [
    "${TAG_PREFIX}:${VERSION}",
    "${TAG_PREFIX}:latest"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "Pulumi CLI container for python."
    "org.opencontainers.image.title" = "${TAG_PREFIX}"
    "org.opencontainers.image.created" = "${timestamp()}"
    "dev.polymathrobotics.image.readme-filepath" = "pulumi/README.md"
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
