variable "IMAGE_NAME" {
  default = "glab"
}

variable "VERSION" {
  default = "1.39.0"
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
    GLAB_URL_AMD64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.39.0/downloads/glab_1.39.0_Linux_x86_64.deb"
    GLAB_SHA256_AMD64 = "309af06ba8c33405a7090e00f5e1cc05ba75fee7fc3ec3c23585a87d97cbcd6a"
    GLAB_URL_ARM64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.39.0/downloads/glab_1.39.0_Linux_arm64.deb"
    GLAB_SHA256_ARM64 = "b905767c81ca36c50516dfbc63679f4a2594b241948cc299d23c65e130963f59"
    GLAB_URL_ARMHF = "https://gitlab.com/gitlab-org/cli/-/releases/v1.39.0/downloads/glab_1.39.0_Linux_arm.deb"
    GLAB_SHA256_ARMHF = "f22423a36377e3d26a7c0a9c51ff33cb75257a447711ce72f1f54949f2d21b35"
    DOCKER_URL_AMD64 = "https://download.docker.com/linux/static/stable/x86_64/docker-26.1.0.tgz"
    DOCKER_URL_ARM64 = "https://download.docker.com/linux/static/stable/aarch64/docker-26.1.0.tgz"
    DOCKER_URL_ARMHF = "https://download.docker.com/linux/static/stable/armhf/docker-26.1.0.tgz"
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
