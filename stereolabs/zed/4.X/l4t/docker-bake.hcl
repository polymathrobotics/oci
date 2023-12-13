variable "IMAGE_NAME" {
  default = "stereolabs-zed"
}

variable "CONTAINER_REGISTRY" {
  default = "docker.io/polymathrobotics"
}

target "default" {
  dockerfile = "Containerfile"
  name = "default-4-0-${tgt}-l4t-r${item.l4t_major_version}-${item.l4t_minor_version}"
  matrix = {
    tgt = ["devel", "tools-devel", "runtime"]
    item = [
      {
        # tag = "4.0-${tgt}-l4t-r35.3"
        l4t_major_version = "35"
        l4t_minor_version = "3"
        l4t_patch_version = "1"
      },
      {
     
        # tag = "4.0-${tgt}-l4t-r35.4"
        l4t_major_version = "35"
        l4t_minor_version = "4"
        l4t_patch_version = "1"
      }
    ]
  }
  target = tgt
  args = {
    L4T_MAJOR_VERSION = "${item.l4t_major_version}"
    L4T_MINOR_VERSION = "${item.l4t_minor_version}"
    L4T_PATCH_VERSION = "${item.l4t_patch_version}"
    ZED_SDK_MAJOR = "4"
    ZED_SDK_MINOR = "0"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:4.0-${tgt}-l4t-r${item.l4t_major_version}.${item.l4t_minor_version}"
  ]
}
