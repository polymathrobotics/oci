variable "TAG_PREFIX" {
  default =  "docker.io/polymathrobotics/ros"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

variable "DISTRO" {
  default = [
    {ros = "humble",  ros_version = "0.10.0-1", ubuntu = "jammy", ubuntu_version = "20240911.1"},
    {ros = "jazzy",   ros_version = "0.11.0-1", ubuntu = "noble", ubuntu_version = "20241015"},
    {ros = "rolling", ros_version = "0.12.0-1", ubuntu = "noble", ubuntu_version = "20241015"},
  ]
}

variable "VARIANT" {
  default = ["ready", "builder"]
}

target "_common" {
  args = {
    ROS_PACKAGES_URI = "http://packages.ros.org/ros2/ubuntu"
    RAW_GITHUBUSERCONTENT_BASE_URL = "https://raw.githubusercontent.com"
    ROSDISTRO_PKGS_SYNC_DATE = "${formatdate("YYYY-MM-DD", timestamp())}"
  }
  dockerfile = "Containerfile"
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci/blob/main/ros/ubuntu/Containerfile"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "The Robot Operating System (ROS) is an open source project for building robot applications."
    "org.opencontainers.image.title" = "${TAG_PREFIX}"
    "org.opencontainers.image.created" = "${timestamp()}"
    "dev.polymathrobotics.image.readme-filepath" = "ros/README.md"
  }
}

target "local" {
  inherits = ["_common"]
  matrix = {
    variant = VARIANT
    distro = DISTRO
  }
  target = variant
  name = "local-${distro.ros}-${variant}"
  tags = [
    "${TAG_PREFIX}:${distro.ros}-${variant}-ubuntu"
  ]
  args = {
    ROS_DISTRO = distro.ros
    ROS_DISTRO_VERSION = distro.ros_version
    UBUNTU_DISTRO = distro.ubuntu
    UBUNTU_DISTRO_VERSION = distro.ubuntu_version
  }
  platforms = ["${LOCAL_PLATFORM}"]
}

target "default" {
  inherits = ["_common"]
  matrix = {
    variant = VARIANT
    distro = DISTRO
  }
  target = variant
  name = "default-${distro.ros}-${variant}"
  tags = [
    "${TAG_PREFIX}:${distro.ros}-${variant}-ubuntu"
  ]
  args = {
    ROS_DISTRO = distro.ros
    ROS_DISTRO_VERSION = distro.ros_version
    UBUNTU_DISTRO = distro.ubuntu
    UBUNTU_DISTRO_VERSION = distro.ubuntu_version
  }
  platforms = ["linux/amd64", "linux/arm64/v8"]
}
