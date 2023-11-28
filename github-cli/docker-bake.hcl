variable "IMAGE_NAME" {
  default = "gh"
}

variable "VERSION" {
  default = "2.39.2"
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
    GITHUB_CLI_URL_AMD64 = "https://github.com/cli/cli/releases/download/v2.39.2/gh_2.39.2_linux_amd64.deb"
    GITHUB_CLI_SHA256_AMD64 = "44093ad78df1f33ff88cd09bbdad8ee2c5d9725d349ed006c78473a6cdc3f165"
    GITHUB_CLI_URL_ARM64 = "https://github.com/cli/cli/releases/download/v2.39.2/gh_2.39.2_linux_arm64.deb"
    GITHUB_CLI_SHA256_ARM64 = "563bd95277076ef6176b17b1e81c00fbf55bb2ef83d4b9b9b2f50b72e1aa28c8"
    GITHUB_CLI_URL_ARMHF = "https://github.com/cli/cli/releases/download/v2.39.2/gh_2.39.2_linux_armv6.deb"
    GITHUB_CLI_SHA256_ARMHF = "36402c214ffaea58cc9a1e8f5c59584d8909613209a968a4b06d68c4682d5914"
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