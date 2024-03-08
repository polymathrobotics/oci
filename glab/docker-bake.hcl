variable "IMAGE_NAME" {
  default = "glab"
}

variable "VERSION" {
  default = "1.37.0"
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
    GLAB_URL_AMD64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.37.0/downloads/glab_1.37.0_Linux_x86_64.deb"
    GLAB_SHA256_AMD64 = "d4a426b0de2d6c4e54772f9876dd3590a987387106528916c41261cb64b5c1bd"
    GLAB_URL_ARM64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.37.0/downloads/glab_1.37.0_Linux_arm64.deb"
    GLAB_SHA256_ARM64 = "c84339d00779aa908642e0cffabd087a0103bcab3a202a4a96fae87404e55a94"
    GLAB_URL_ARMHF = "https://gitlab.com/gitlab-org/cli/-/releases/v1.37.0/downloads/glab_1.37.0_Linux_arm.deb"
    GLAB_SHA256_ARMHF = "7ab344118db329313ffff622affbfabf3f95fb2551750efa681eaf8f2c90fa2f"
    DOCKER_URL_AMD64 = "https://download.docker.com/linux/static/stable/x86_64/docker-25.0.4.tgz"
    DOCKER_URL_ARM64 = "https://download.docker.com/linux/static/stable/aarch64/docker-25.0.4.tgz"
    DOCKER_URL_ARMHF = "https://download.docker.com/linux/static/stable/armhf/docker-25.0.4.tgz"
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
