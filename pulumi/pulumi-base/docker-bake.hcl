target "default" {
  tags = [
    "docker.io/polymathrobotics/pulumi-base:3.94.0",
    "docker.io/polymathrobotics/pulumi-base:latest"
  ]
  dockerfile = "Containerfile"
  platforms = ["linux/arm64/v8", "linux/amd64"]
}
