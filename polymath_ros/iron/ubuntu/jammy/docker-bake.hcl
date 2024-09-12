variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/polymath_ros"
  # default = "docker.hq0-nexus01.sandbox.polymathrobotics.dev/polymathrobotics/polymath_ros"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

variable "ROS_PACKAGE" {
  default = ["ros-base", "perception", "simulation", "desktop", "desktop-full"]
}

target "_common" {
  args = {
    BASE_IMAGE = "docker.io/polymathrobotics/ros:iron-ros-base-jammy"
    # BASE_IMAGE = "docker.hq0-nexus01.sandbox.polymathrobotics.dev/ros:iron-ros-base-jammy"
  }
  dockerfile = "Containerfile"
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci/blob/main/polymath_ros/iron/ubuntu/jammy/Containerfile"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "Polymath Robotics dependencies on top of OSRF based ROS images."
    "org.opencontainers.image.title" = "Polymath ROS Iron"
    "org.opencontainers.image.created" = "${timestamp()}"
    "dev.polymathrobotics.image.readme-filepath" = "polymath_ros/README.md"
  }
}

target "local" {
  inherits = ["_common"]
  name = "local-${ros_package}"
  matrix = {
    ros_package = ROS_PACKAGE
  }
  args = {
    BASE_IMAGE = "docker.io/polymathrobotics/ros:iron-${ros_package}-jammy"
    // BASE_IMAGE = "docker.hq0-nexus01.sandbox.polymathrobotics.dev/ros:iron-${ros_package}-jammy"
  }
  tags = [
    "${TAG_PREFIX}:iron-${ros_package}-jammy"
  ]
  platforms = ["${LOCAL_PLATFORM}"]
}

target "default" {
  inherits = ["_common"]
  name = "default-${ros_package}"
  matrix = {
    ros_package = ROS_PACKAGE
  }
  args = {
    BASE_IMAGE = "docker.io/polymathrobotics/ros:iron-${ros_package}-jammy"
    // BASE_IMAGE = "docker.hq0-nexus01.sandbox.polymathrobotics.dev/ros:iron-${ros_package}-jammy"
  }
  tags = [
    "${TAG_PREFIX}:iron-${ros_package}-jammy"
  ]
  platforms = ["linux/amd64", "linux/arm64/v8"]
  # cache-from = ["type=registry,ref=docker-cache.hq0-nexus01.sandbox.polymathrobotics.dev/polymathrobotics/polymath_ros:iron-${ros_package}-jammy"]
  # cache-to = ["type=registry,ref=docker-cache.hq0-nexus01.sandbox.polymathrobotics.dev/polymathrobotics/polymath_ros:iron-${ros_package}-jammy"]
}
