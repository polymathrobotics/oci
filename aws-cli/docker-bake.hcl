target "default" {
  tags = [
    "docker.io/polymathrobotics/aws-cli:2.13.28",
    "docker.io/polymathrobotics/aws-cli:latest"
  ]
  dockerfile = "Containerfile"
  platforms = ["linux/amd64", "linux/arm64/v8"]
}
