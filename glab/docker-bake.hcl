target "default" {
  tags = [
    "docker.io/polymathrobotics/glab:1.35.0",
    "docker.io/polymathrobotics/glab:latest"
  ]
  dockerfile = "Containerfile"
  platforms = ["linux/amd64", "linux/arm64/v8", "linux/arm/v7"]
}
