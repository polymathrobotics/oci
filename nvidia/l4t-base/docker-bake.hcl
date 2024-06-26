variable "CONTAINER_REGISTRY" {
  default = "docker.io/polymathrobotics"
}

variable "IMAGE_NAME" {
  default = "nvidia-l4t-base"
}

variable "L4T_RELEASE" {
  default = [
    { version = "35.3.1", release = "r35.3", dockerfile = "Containerfile.r35" },
    { version = "35.4.1", release = "r35.4", dockerfile = "Containerfile.r35" },
    { version = "36.2.0", release = "r36.2", dockerfile = "Containerfile.r36" },
  ]
}

target "_common" {
  # dockerfile = item.dockerfile
  platforms = ["linux/arm64/v8"]
  labels = {
    "org.opencontainers.image.created" = timestamp()
    "org.opencontainers.image.description" = "Linux for Tegra (L4T) base image for the NVIDIA Jetson embedded computing platform."
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.title" = "${IMAGE_NAME}"
  }
}

target "local" {
  name = "local-${IMAGE_NAME}-${replace(item.version, ".", "-")}"
  inherits = ["_common"]
  target = "nvidia-l4t-base"
  args = {
    RELEASE = item.release
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${item.version}"
  ]
  dockerfile = item.dockerfile
  matrix = {
    item = L4T_RELEASE
  }
}

target "default" {
  name = "default-${IMAGE_NAME}-${replace(item.version, ".", "-")}"
  inherits = ["_common"]
  target = "nvidia-l4t-base"
  args = {
    RELEASE = item.release
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${item.version}"
  ]
  dockerfile = item.dockerfile
  matrix = {
    item = L4T_RELEASE
  }
}
