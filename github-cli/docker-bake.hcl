variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/gh"
}

variable "VERSION" {
  default = "2.55.0"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  args = {
    GITHUB_CLI_VERSION = "${VERSION}"
    GITHUB_CLI_URL_AMD64 = "https://github.com/cli/cli/releases/download/v2.55.0/gh_2.55.0_linux_amd64.deb"
    GITHUB_CLI_SHA256_AMD64 = "21f2c7b31da7b8801297ae6aee1feacb4508771483b76bf68a197d7162cb754f"
    GITHUB_CLI_URL_ARM64 = "https://github.com/cli/cli/releases/download/v2.55.0/gh_2.55.0_linux_arm64.deb"
    GITHUB_CLI_SHA256_ARM64 = "765294a217ef2972e036d8d0954de5eaa5391bb05671ee74f47a791ef4c43289"
  }
  dockerfile = "Containerfile"
  tags = [
    "${TAG_PREFIX}:${VERSION}",
    "${TAG_PREFIX}:latest",
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "The GitLab CLI tool."
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