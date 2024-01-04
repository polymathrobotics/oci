variable "IMAGE_NAME" {
  default = "stereolabs-zedbot"
}

variable "CONTAINER_REGISTRY" {
  default = "docker.io/polymathrobotics"
}

variable "L4T_VERSION" {
  default = [
    {
        l4t_major_version = "35"
        l4t_minor_version = "3"
        l4t_patch_version = "1"
      },
      {

        l4t_major_version = "35"
        l4t_minor_version = "4"
        l4t_patch_version = "1"
      }
  ]
}

variable "ROS_PACKAGE" {
  default = ["ros_base", "desktop"]
}

target "_common" {
  dockerfile = "Containerfile"
  platforms = ["linux/arm64/v8"]
  labels = {
    "org.opencontainers.image.created" = timestamp()
    "org.opencontainers.image.description" = "StereoLabs ZED SDK with ROS2 Hubmle on L4T."
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.title" = "${IMAGE_NAME}"
  }
}

target "local" {
  name = "local-humble-${ros_package}-l4t${item.l4t_major_version}-${item.l4t_minor_version}-zed-4-0"
  matrix = {
    item = L4T_VERSION
    ros_package = ROS_PACKAGE
  }
  args = {
    BASE_IMAGE = "${CONTAINER_REGISTRY}/nvidia-l4t-ros:humble-${ros_package}-r${item.l4t_major_version}.${item.l4t_minor_version}.${item.l4t_patch_version}"
    L4T_MAJOR = "${item.l4t_major_version}"
    L4T_MINOR = "${item.l4t_minor_version}"
    ZED_SDK_MAJOR = "4"
    ZED_SDK_MINOR = "0"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:humble-${ros_package}-${item.l4t_major_version}.${item.l4t_minor_version}-zed-4.0"
  ]
}

target "default" {
  name = "default-humble-${ros_package}-l4t${item.l4t_major_version}-${item.l4t_minor_version}-zed-4-0"
  matrix = {
    item = L4T_VERSION
    ros_package = ROS_PACKAGE
  }
  args = {
    BASE_IMAGE = "${CONTAINER_REGISTRY}/nvidia-l4t-ros:humble-${ros_package}-r${item.l4t_major_version}.${item.l4t_minor_version}.${item.l4t_patch_version}"
    L4T_MAJOR = "${item.l4t_major_version}"
    L4T_MINOR = "${item.l4t_minor_version}"
    ZED_SDK_MAJOR = "4"
    ZED_SDK_MINOR = "0"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:humble-${ros_package}-${item.l4t_major_version}.${item.l4t_minor_version}-zed-4.0"
  ]
}
