variable "CONTAINER_REGISTRY" {
  default = "docker.io/polymathrobotics"
}

variable "IMAGE_NAME" {
  default = "nvidia-l4t-jetpack"
}

variable "JETPACK_VERSION" {
  default = ["35.3.1", "35.4.1"]
}

target "_common" {
  dockerfile = "Containerfile"
  platforms = ["linux/arm64/v8"]
  labels = {
    "org.opencontainers.image.created" = timestamp()
    "org.opencontainers.image.description" = "NVIDIA JetPack SDK."
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.title" = "${IMAGE_NAME}"
  }
}

target "local" {
  name = "local-${IMAGE_NAME}-${replace(tag, ".", "-")}"
  inherits = ["_common"]
  args = {
    TAG = tag
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:r${tag}"
  ]
  matrix = {
    tag = JETPACK_VERSION
  }
}

target "default" {
  name = "default-${IMAGE_NAME}-${replace(tag, ".", "-")}"
  inherits = ["_common"]
  args = {
    TAG = tag
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:r${tag}"
  ]
  matrix = {
    tag = JETPACK_VERSION
  }
}
