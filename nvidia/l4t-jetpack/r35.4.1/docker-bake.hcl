target "default" {
  tags = ["docker.io/polymathrobotics/nvidia-l4t-jetpack:r35.4.1"]
  dockerfile = "Containerfile"
  platforms = ["linux/arm64"]
}
