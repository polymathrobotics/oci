variable "CONTAINER_REGISTRY" {
  default = "docker.io/polymathrobotics"
}

variable "IMAGE_NAME" {
  default = "nvidia-l4t-ros"
}

target "default" {
  name = "${IMAGE_NAME}-${ros_version}-${ros_package}-${replace(base_image, ".", "-")}"
  args = {
    BASE_IMAGE = "docker.io/polymathrobotics/nvidia-l4t-jetpack:${base_image}"
    ROS_VERSION = "${ros_version}"
    ROS_PACKAGE = "${ros_package}"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${ros_version}-${ros_package}-${base_image}"
  ]
  dockerfile = "Containerfile"
  platforms = ["linux/arm64/v8"]
  labels = {
    "org.opencontainers.image.created" = timestamp()
    "org.opencontainers.image.description" = "The Robot Operating System (ROS) is an open source project for building robot applications."
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
  }
  matrix = {
    base_image = ["r35.3.1", "r35.4.1"]
    ros_version = ["humble"]
    ros_package = ["ros_base", "ros_core", "desktop"]
  }
}
