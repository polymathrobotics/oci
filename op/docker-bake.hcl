variable "IMAGE_NAME" {
  default = "op"
}

variable "VERSION" {
  default = "2.17.0-beta.01"
}

variable "CONTAINER_REGISTRY" {
  default = "docker.io/polymathrobotics"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  dockerfile = "Containerfile"
  args = {
    OP_CLI_URL_AMD64 = "https://cache.agilebits.com/dist/1P/op2/pkg/v2.17.0-beta.01/op_linux_amd64_v2.17.0-beta.01.zip"
    OP_CLI_URL_ARM64 = "https://cache.agilebits.com/dist/1P/op2/pkg/v2.17.0-beta.01/op_linux_arm64_v2.17.0-beta.01.zip"
    OP_CLI_URL_ARMHF = "https://cache.agilebits.com/dist/1P/op2/pkg/v2.17.0-beta.01/op_linux_arm_v2.17.0-beta.01.zip"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${VERSION}",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:2",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:latest",
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "1Password command-line interface."
    "org.opencontainers.image.title" = "${IMAGE_NAME}"
  }
}

target "local" {
  inherits = ["_common"]
  platforms = ["${LOCAL_PLATFORM}"]
}

target "default" {
  inherits = ["_common"]
  platforms = ["linux/amd64", "linux/arm64/v8"]
} 