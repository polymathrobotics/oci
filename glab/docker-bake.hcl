variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/glab"
}

variable "VERSION" {
  default = "1.46.1"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  args = {
    GLAB_VERSION = "${VERSION}"
    GLAB_URL_AMD64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.46.1/downloads/glab_1.46.1_Linux_x86_64.deb"
    GLAB_SHA256_AMD64 = "bf8c53df12d23bf204cba7ae499c4721009e64b2a39277c814759000ac4d3fdd"
    GLAB_URL_ARM64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.46.1/downloads/glab_1.46.1_Linux_arm64.deb"
    GLAB_SHA256_ARM64 = "c2850b8f9e2fe886dc01232570be5abc40106d0cdac3e2bc7b4d47ea444c8d47"
    DOCKER_URL_AMD64 = "https://download.docker.com/linux/static/stable/x86_64/docker-27.2.1.tgz"
    DOCKER_URL_ARM64 = "https://download.docker.com/linux/static/stable/aarch64/docker-27.2.1.tgz"
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
