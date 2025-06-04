variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/glab"
}

variable "VERSION" {
  default = "1.56.0"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  args = {
    GLAB_VERSION = "${VERSION}"
    GLAB_URL_AMD64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.56.0/downloads/glab_1.56.0_linux_amd64.deb"
    GLAB_SHA256_AMD64 = "44844169064c15c34f26207cece04872ca400993b29a7eac12047135e0fbebb0"
    GLAB_URL_ARM64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.56.0/downloads/glab_1.56.0_linux_arm64.deb"
    GLAB_SHA256_ARM64 = "8b1335b5dde39a7a06c7aa12637857aeb27463f2ef08c0e26cb1b8589cdaa974"
    DOCKER_URL_AMD64 = "https://download.docker.com/linux/static/stable/x86_64/docker-28.1.1.tgz"
    DOCKER_URL_ARM64 = "https://download.docker.com/linux/static/stable/aarch64/docker-28.1.1.tgz"
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
