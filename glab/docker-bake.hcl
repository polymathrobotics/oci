variable "IMAGE_NAME" {
  default = "glab"
}

variable "VERSION" {
  default = "1.38.0"
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
    GLAB_URL_AMD64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.38.0/downloads/glab_1.38.0_Linux_x86_64.deb"
    GLAB_SHA256_AMD64 = "a751bb6b782f0c87287a0ca0dff1097681996284045a1cf0f69a336f8be57225"
    GLAB_URL_ARM64 = "https://gitlab.com/gitlab-org/cli/-/releases/v1.38.0/downloads/glab_1.38.0_Linux_arm64.deb"
    GLAB_SHA256_ARM64 = "b7810fa1824a783396e116560d80b661ec84fcd588dbf48b24cafc6d31c33a85"
    GLAB_URL_ARMHF = "https://gitlab.com/gitlab-org/cli/-/releases/v1.38.0/downloads/glab_1.38.0_Linux_arm.deb"
    GLAB_SHA256_ARMHF = "29801ea2a5ebc6413c45cb8dd3283ea97418fe50b7962fe09b18c111531d2fb7"
    DOCKER_URL_AMD64 = "https://download.docker.com/linux/static/stable/x86_64/docker-25.0.5.tgz"
    DOCKER_URL_ARM64 = "https://download.docker.com/linux/static/stable/aarch64/docker-25.0.5.tgz"
    DOCKER_URL_ARMHF = "https://download.docker.com/linux/static/stable/armhf/docker-25.0.5.tgz"
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
