variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/glab"
}

variable "VERSION" {
  default = "1.53.0"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  args = {
    GLAB_VERSION = "${VERSION}"
    GLAB_URL_AMD64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.53.0/downloads/glab_1.53.0_linux_amd64.deb"
    GLAB_SHA256_AMD64 = "633fa8eea4c4f081b0fa8a602dd10a9885ee08bb5391fdefc9dcaa1dbb110531"
    GLAB_URL_ARM64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.53.0/downloads/glab_1.53.0_linux_arm64.deb"
    GLAB_SHA256_ARM64 = "c159dec458ec3610d20dea93939eb8a95b29c6fd52c50de5bbaa8f6af2bba5b1"
    DOCKER_URL_AMD64 = "https://download.docker.com/linux/static/stable/x86_64/docker-28.0.1.tgz"
    DOCKER_URL_ARM64 = "https://download.docker.com/linux/static/stable/aarch64/docker-28.0.1.tgz"
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
