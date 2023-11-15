target "default" {
  tags = [
    "docker.io/polymathrobotics/pulumi-python:3.94.0",
    "docker.io/polymathrobotics/pulumi-python:latest"
  ]
  dockerfile = "Containerfile"
  platforms = ["linux/arm64/v8", "linux/amd64"]
}
