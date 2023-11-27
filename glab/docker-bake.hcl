variable "IMAGE_NAME" {
  default = "glab"
}

variable "VERSION" {
  default = "1.35.0"
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
    MDL_VERSION = "${VERSION}"
    GLAB_URL_AMD64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.35.0/downloads/glab_1.35.0_Linux_x86_64.deb"
    GLAB_SHA256_AMD64 = "52380af6077cff5d2d142efafdab2c3789e32299e2061f0373b2a252d01dabf5"
    GLAB_URL_ARM64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.35.0/downloads/glab_1.35.0_Linux_arm64.deb"
    GLAB_SHA256_ARM64 = "2bbf189d335fc9c7d4ec9c2a0834a9503593b523a29d73dae0bc0988d68cb359"
    GLAB_URL_ARMHF = "https://gitlab.com/gitlab-org/cli/-/releases/v1.35.0/downloads/glab_1.35.0_Linux_arm.deb"
    GLAB_SHA256_ARMHF = "a574c6c197decd29c815bfbfe9c6a1da3b6c2f5cc7fee36d4554dbbae7b607de"
    DOCKER_URL_AMD64 = "https://download.docker.com/linux/static/stable/x86_64/docker-24.0.7.tgz"
    DOCKER_URL_ARM64 = "https://download.docker.com/linux/static/stable/aarch64/docker-24.0.7.tgz"
    DOCKER_URL_ARMHF = "https://download.docker.com/linux/static/stable/armhf/docker-24.0.7.tgz"
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