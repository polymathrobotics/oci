target "default" {
  tags = ["docker.io/polymathrobotics/jfrog-cli:2.50.2",
          "docker.io/polymathrobotics/jfrog-cli:latest"]
  dockerfile = "Containerfile"
  platforms = ["linux/amd64", "linux/arm64/v8", "linux/arm/v7"]
}
