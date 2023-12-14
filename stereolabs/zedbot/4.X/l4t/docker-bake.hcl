variable "IMAGE_NAME" {
  default = "stereolabs-zed"
}

variable "CONTAINER_REGISTRY" {
  default = "docker.io/polymathrobotics"
}

target "default" {
  dockerfile = "Containerfile"
  name = "default-humble-${ros_package}-l4t${item.l4t_major_version}-${item.l4t_minor_version}-zed-4-0"
  matrix = {
    item = [
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
    ros_package = ["ros-base", "desktop"]
  }
  args = {
    BASE_IMAGE = "${CONTAINER_REGISTRY}/ros:humble-${ros_package}-${item.l4t_major_version}.${item.l4t_minor_version}.${item.l4t_patch_version}"
    L4T_MAJOR = "${item.l4t_major_version}"
    L4T_MINOR = "${item.l4t_minor_version}"
    ZED_SDK_MAJOR = "4"
    ZED_SDK_MINOR = "0"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:humble-${ros_package}-${item.l4t_major_version}.${item.l4t_minor_version}-zed-4.0"
  ]
}
