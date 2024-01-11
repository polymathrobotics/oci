variable "IMAGE_NAME" {
  default = "gh"
}

variable "VERSION" {
  default = "2.42.0"
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
    GITHUB_CLI_VERSION = "${VERSION}"
    GITHUB_CLI_URL_AMD64 = "https://github.com/cli/cli/releases/download/v2.42.0/gh_2.42.0_linux_amd64.deb"
    GITHUB_CLI_SHA256_AMD64 = "b51d0d771b1826445fc303a7ae15b4176bb7a138357134389a149ae0901fa2c0"
    GITHUB_CLI_URL_ARM64 = "https://github.com/cli/cli/releases/download/v2.42.0/gh_2.42.0_linux_arm64.deb"
    GITHUB_CLI_SHA256_ARM64 = "cfcbb63e2cef4ef5b1526bc5c16f84a247b57bf7f30d73131202923c747f2eec"
    GITHUB_CLI_URL_ARMHF = "https://github.com/cli/cli/releases/download/v2.42.0/gh_2.42.0_linux_armv6.deb"
    GITHUB_CLI_SHA256_ARMHF = "6503c7d3f1fe74154ae5a80c77297249439b6729a5fcf952610c8850d2ca9efd"
  }
  dockerfile = "Containerfile"
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${VERSION}",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:latest",
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "The GitLab CLI tool."
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