variable "IMAGE_NAME" {
  default = "nvidia-l4t-ros"
}

variable "CONTAINER_REGISTRY" {
  default = "docker.io/polymathrobotics"
}

variable "L4T_BASE_IMAGE" {
  default = ["r35.3.1", "r35.4.1"]
}

variable "ROS_VERSION" {
  default = ["humble"]
}

variable "ROS_PACKAGE" {
  default = ["ros_base", "ros_core", "desktop"]
}


target "_common" {
  dockerfile = "Containerfile"
  platforms = ["linux/arm64/v8"]
  labels = {
    "org.opencontainers.image.title" = "${IMAGE_NAME}"
    "org.opencontainers.image.created" = timestamp()
    "org.opencontainers.image.description" = "The Robot Operating System (ROS) is an open source project for building robot applications."
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
  }
}

target "local" {
  inherits = ["_common"]
  name = "local-${IMAGE_NAME}-${ros_version}-${ros_package}-${replace(base_image, ".", "-")}"
  args = {
    BASE_IMAGE = "docker.io/polymathrobotics/nvidia-l4t-jetpack:${base_image}"
    ROS_VERSION = "${ros_version}"
    ROS_PACKAGE = "${ros_package}"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${ros_version}-${ros_package}-${base_image}"
  ]
  matrix = {
    base_image = L4T_BASE_IMAGE
    ros_version = ROS_VERSION
    ros_package = ROS_PACKAGE
  }
}

target "default" {
  inherits = ["_common"]
  name = "default-${IMAGE_NAME}-${ros_version}-${ros_package}-${replace(base_image, ".", "-")}"
  args = {
    BASE_IMAGE = "docker.io/polymathrobotics/nvidia-l4t-jetpack:${base_image}"
    ROS_VERSION = "${ros_version}"
    ROS_PACKAGE = "${ros_package}"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${ros_version}-${ros_package}-${base_image}"
  ]
  matrix = {
    base_image = L4T_BASE_IMAGE
    ros_version = ROS_VERSION
    ros_package = ROS_PACKAGE
  }
}
