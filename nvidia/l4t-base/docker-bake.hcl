variable "CONTAINER_REGISTRY" {
  default = "docker.io/polymathrobotics"
}

variable "IMAGE_NAME" {
  default = "nvidia-l4t-base"
}

target "lint" {
  dockerfile = "Containerfile"
  target = "lint"
}

# Special target: https://github.com/docker/metadata-action#bake-definition
target "docker-metadata-action" { }

target "nvidia-l4t-base" {
  inherits = ["docker-metadata-action"]
  name = "${IMAGE_NAME}-${item.name}"
  target = "nvidia-l4t-base"
  args = {
    RELEASE = item.release
  }
  tags = item.tags
  dockerfile = "Containerfile"
  platforms = ["linux/arm64/v8"]
  labels = {
    "org.opencontainers.image.created" = timestamp()
    "org.opencontainers.image.description" = "Linux for Tegra (L4T) base image for the NVIDIA Jetson embedded computing platform."
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
  }
  matrix = {
    item = [
      { name = "r35_3", release = "r35.3", tags = ["${CONTAINER_REGISTRY}/${IMAGE_NAME}:35.3.1"] },
      { name = "r35_4", release = "r35.4", tags = ["${CONTAINER_REGISTRY}/${IMAGE_NAME}:35.4.1"] },
    ]
  }
}
