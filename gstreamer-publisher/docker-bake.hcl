variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/gstreamer-publisher"
}

variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

variable "DISTRO" {
  default = [
    {
      name = "jammy"
      build_image = "docker.io/polymathrobotics/ros:humble-builder-ubuntu"
      runtime_base_image = "docker.io/ubuntu:jammy-20260217"
      gstreamer_publisher_ref = "8825fee6f40ff51f2cf9347892f6fbc08eeb1f2e"
    },
    {
      name = "noble"
      build_image = "docker.io/polymathrobotics/ros:rolling-builder-ubuntu"
      runtime_base_image = "docker.io/ubuntu:noble-20260217"
      gstreamer_publisher_ref = "407891dbdca2ad3113270fbeb350ab9f47615917"
    },
  ]
}

target "_common" {
  dockerfile = "Containerfile"
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci/tree/main/gstreamer-publisher"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "Command-line app that publishes any GStreamer pipeline to LiveKit."
    "org.opencontainers.image.title" = "${TAG_PREFIX}"
    "org.opencontainers.image.created" = "${timestamp()}"
    "dev.polymathrobotics.image.readme-filepath" = "gstreamer-publisher/README.md"
  }
}

target "local" {
  inherits = ["_common"]
  matrix = {
    distro = DISTRO
  }
  name = "local-${distro.name}"
  tags = [
    "${TAG_PREFIX}:${distro.name}",
    "${TAG_PREFIX}:${distro.name}-${distro.gstreamer_publisher_ref}",
  ]
  args = {
    BUILD_IMAGE = distro.build_image
    GOLANG_IMAGE = "docker.io/polymathrobotics/golang:1.24-noble"
    GSTREAMER_PUBLISHER_REF = distro.gstreamer_publisher_ref
    RUNTIME_BASE_IMAGE = distro.runtime_base_image
  }
  platforms = ["${LOCAL_PLATFORM}"]
}

target "default" {
  inherits = ["_common"]
  matrix = {
    distro = DISTRO
  }
  name = "default-${distro.name}"
  tags = [
    "${TAG_PREFIX}:${distro.name}",
    "${TAG_PREFIX}:${distro.name}-${distro.gstreamer_publisher_ref}",
  ]
  args = {
    BUILD_IMAGE = distro.build_image
    GOLANG_IMAGE = "docker.io/polymathrobotics/golang:1.24-noble"
    GSTREAMER_PUBLISHER_REF = distro.gstreamer_publisher_ref
    RUNTIME_BASE_IMAGE = distro.runtime_base_image
  }
  platforms = ["linux/amd64"]
}
