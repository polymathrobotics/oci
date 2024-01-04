variable "IMAGE_NAME" {
  default = "stereolabs-zed"
}

variable "CONTAINER_REGISTRY" {
  default = "docker.io/polymathrobotics"
}

variable "L4T_VERSION" {
  default = [
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

target "_common" {
  dockerfile = "Containerfile"
  platforms = ["linux/arm64/v8"]
  labels = {
    "org.opencontainers.image.created" = timestamp()
    "org.opencontainers.image.description" = "StereoLabs ZED SDK."
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.title" = "${IMAGE_NAME}"
  }
}

target "local" {
  inherits = ["_common"]
  name = "default-4-0-${tgt}-l4t-r${item.l4t_major_version}-${item.l4t_minor_version}"
  matrix = {
    tgt = ["devel", "tools-devel", "runtime", "py-devel", "py-runtime"]
    item = L4T_VERSION
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

target "default" {
  inherits = ["_common"]
  name = "default-4-0-${tgt}-l4t-r${item.l4t_major_version}-${item.l4t_minor_version}"
  matrix = {
    tgt = ["devel", "tools-devel", "runtime", "py-devel", "py-runtime"]
    item = L4T_VERSION
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
