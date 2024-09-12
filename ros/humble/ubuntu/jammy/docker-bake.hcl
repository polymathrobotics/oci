variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/ros"
  # default = "docker.hq0-nexus01.sandbox.polymathrobotics.dev/polymathrobotics/ros"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

variable "ROS_PACKAGE" {
  default = ["ros-core", "ros-base", "perception", "simulation", "desktop", "desktop-full"]
}

target "_common" {
  args = {
    BASE_IMAGE = "docker.io/ubuntu:jammy-20240808"
    # BASE_IMAGE = "docker.hq0-nexus01.sandbox.polymathrobotics.dev/ubuntu:jammy-20240808"
    ROS_PACKAGES_URI = "http://packages.ros.org/ros2/ubuntu"
    # ROS_PACKAGES_URI = "http://hq0-nexus01.sandbox.polymathrobotics.dev/repository/ros-apt-proxy"
    RAW_GITHUBUSERCONTENT_BASE_URL = "https://raw.githubusercontent.com"
    # RAW_GITHUBUSERCONTENT_BASE_URL = "https://hq0-nexus01.sandbox.polymathrobotics.dev/repository/githubusercontent-proxy"
  }
  dockerfile = "Containerfile"
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci/blob/main/ros/humble/ubuntu/jammy/Containerfile"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "The Robot Operating System (ROS) is an open source project for building robot applications."
    "org.opencontainers.image.title" = "${TAG_PREFIX}"
    "org.opencontainers.image.created" = "${timestamp()}"
    "dev.polymathrobotics.image.readme-filepath" = "ros/README.md"
  }
}

target "local" {
  inherits = ["_common"]
  name = "local-${ros_package}"
  target = ros_package
  matrix = {
    ros_package = ROS_PACKAGE
  }
  tags = [
    "${TAG_PREFIX}:humble-${ros_package}-jammy"
  ]
  platforms = ["${LOCAL_PLATFORM}"]
}

target "default" {
  inherits = ["_common"]
  name = "default-${ros_package}"
  target = ros_package
  matrix = {
    ros_package = ROS_PACKAGE
  }
  tags = [
    "${TAG_PREFIX}:humble-${ros_package}-jammy"
  ]
  platforms = ["linux/amd64", "linux/arm64/v8"]
  # cache-from = ["type=registry,ref=docker-cache.hq0-nexus01.sandbox.polymathrobotics.dev/polymathrobotics/ros:humble-${ros_package}-jammy"]
  # cache-to = ["type=registry,ref=docker-cache.hq0-nexus01.sandbox.polymathrobotics.dev/polymathrobotics/ros:humble-${ros_package}-jammy"]
}
