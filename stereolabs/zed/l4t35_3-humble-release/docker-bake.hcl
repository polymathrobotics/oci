target "default" {
  tags = ["docker.io/polymathrobotics/zed:l4t35_3-humble-release"]
  dockerfile = "Containerfile"
  platforms = ["linux/arm64/v8"]
}
