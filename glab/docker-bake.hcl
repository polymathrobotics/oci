variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/glab"
}

variable "VERSION" {
  default = "1.47.0"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  args = {
    GLAB_VERSION = "${VERSION}"
    GLAB_URL_AMD64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.47.0/downloads/glab_1.47.0_linux_amd64.deb"
    GLAB_SHA256_AMD64 = "cbc09492b2b313b2457651f00ee62677ae11442279c4cc67377aeea66b260144"
    GLAB_URL_ARM64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.47.0/downloads/glab_1.47.0_linux_arm64.deb"
    GLAB_SHA256_ARM64 = "ab9de6ba9e4b8d8b6f9e3c11de138c1b9342e879ff07f9a502d49a7dae2244b9"
    DOCKER_URL_AMD64 = "https://download.docker.com/linux/static/stable/x86_64/docker-27.3.1.tgz"
    DOCKER_URL_ARM64 = "https://download.docker.com/linux/static/stable/aarch64/docker-27.3.1.tgz"
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
