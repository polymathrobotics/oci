variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/polymath-ros"
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
    BASE_IMAGE = "docker.io/polymathrobotics/ros:humble-ros-base-jammy"
  }
  dockerfile = "Containerfile"
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "Polymath Robotics defaults on top of OSRF-based ROS images."
    "org.opencontainers.image.title" = "${TAG_PREFIX}"
    "org.opencontainers.image.created" = "${timestamp()}"
    "dev.polymathrobotics.image.readme-filepath" = "polymath-ros/README.md"
  }
}

target "local" {
  inherits = ["_common"]
  name = "local-${ros_package}"
  matrix = {
    ros_package = ROS_PACKAGE
  }
  args = {
    BASE_IMAGE = "docker.io/polymathrobotics/ros:humble-${ros_package}-jammy"
  }
  tags = [
    "${TAG_PREFIX}:humble-${ros_package}-jammy"
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
    BASE_IMAGE = "docker.io/polymathrobotics/ros:humble-${ros_package}-jammy"
  }
  tags = [
    "${TAG_PREFIX}:humble-${ros_package}-jammy"
  ]
  platforms = ["linux/amd64", "linux/arm64/v8"]
} 
