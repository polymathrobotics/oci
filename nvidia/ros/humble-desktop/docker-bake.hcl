target "default" {
  tags = ["docker.io/polymathrobotics/ros:humble-desktop-l4t-r35.4.1"]
  dockerfile = "Containerfile"
  platforms = ["linux/arm64"]
}
