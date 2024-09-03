variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/glab"
}

variable "VERSION" {
  default = "1.45.0"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  args = {
    MDL_VERSION = "${VERSION}"
    GLAB_URL_AMD64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.45.0/downloads/glab_1.45.0_Linux_x86_64.deb"
    GLAB_SHA256_AMD64 = "3efe5be6d5fd6c3346d2cabd2ca35d7f85a5ae5d97da8c90dff81557124dc519"
    GLAB_URL_ARM64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.45.0/downloads/glab_1.45.0_Linux_arm64.deb"
    GLAB_SHA256_ARM64 = "2bd45d6d0f7c6af15604720dc8d177a3a15661230bcee45334879c5928de57bc"
    DOCKER_URL_AMD64 = "https://download.docker.com/linux/static/stable/x86_64/docker-27.2.0.tgz"
    DOCKER_URL_ARM64 = "https://download.docker.com/linux/static/stable/aarch64/docker-27.2.0.tgz"
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
