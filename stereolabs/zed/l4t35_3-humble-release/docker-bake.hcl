# Declare an empty target for https://github.com/docker/metadata-action
target "docker-metadata-action" {}

target "local" {
  tags = ["docker.io/polymathrobotics/zed:l4t35_3-humble-release"]
  dockerfile = "Containerfile"
  platforms = ["linux/arm64/v8"]
}

target "default" {
  inherits = [ "docker-metadata-action"]
  tags = ["docker.io/polymathrobotics/zed:l4t35_3-humble-release"]
  dockerfile = "Containerfile"
  platforms = ["linux/arm64/v8"]
}
