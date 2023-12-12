variable "IMAGE_NAME" {
  default  = "stereolabs-zed"
}

variable "CONTAINER_REGISTRY" {
  default = "docker.io/polymathrobotics"
}

target "default" {
  dockerfile = "Containerfile"
  name = "default-${replace(item.tgt, ".", "-")}"
  matrix = {
    item = [
      {
        tgt = "4.0-tools-devel-l4t-r35.3"
        l4t_major_version = "35"
        l4t_minor_version = "3"
        l4t_patch_version = "1"
      },
      {
     
        tgt = "4.0-tools-devel-l4t-r35.4"
        l4t_major_version = "35"
        l4t_minor_version = "4"
        l4t_patch_version = "1"
      }
    ]
  }
  args = {
    L4T_MAJOR_VERSION = "${item.l4t_major_version}"
    L4T_MINOR_VERSION = "${item.l4t_minor_version}"
    L4T_PATCH_VERSION = "${item.l4t_patch_version}"
    ZED_SDK_MAJOR = "4"
    ZED_SDK_MINOR = "0"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${item.tgt}"
  ]
}
