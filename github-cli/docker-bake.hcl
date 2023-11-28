variable "IMAGE_NAME" {
  default = "gh"
}

variable "VERSION" {
  default = "2.13.0"
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
    GITHUB_CLI_URL_AMD64 = "https://github.com/cli/cli/releases/download/v2.13.0/gh_2.13.0_linux_amd64.deb"
    GITHUB_CLI_SHA256_AMD64 = "b4d69e1d00cca2f35f3d12c4f3116f469f6fc2ef3449d8924a253c0f41cb7a94"
    GITHUB_CLI_URL_ARM64 = "https://github.com/cli/cli/releases/download/v2.13.0/gh_2.13.0_linux_arm64.deb"
    GITHUB_CLI_SHA256_ARM64 = "a34082dd15c7a3c594be2a64701b14cf10fd7dd2ee60498fbea0ee83a7df5a9e"
    GITHUB_CLI_URL_ARMHF = "https://github.com/cli/cli/releases/download/v2.13.0/gh_2.13.0_linux_armv6.deb"
    GITHUB_CLI_SHA256_ARMHF = "17ca4a818ce177460d5158d0d92a0b6ece6019d33844e06561ff51a1abdefcc7"
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