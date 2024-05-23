variable "IMAGE_NAME" {
  default = "jfrog-cli"
}

variable "VERSION" {
  default = "2.57.0"
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
    JFROG_CLI_VERSION = "${VERSION}"
    JFROG_CLI_URL_AMD64 = "https://releases.jfrog.io/artifactory/jfrog-cli/v2-jf/2.57.0/jfrog-cli-linux-amd64/jf"
    JFROG_CLI_SHA256_AMD64 = "9abb6fe9fad6479181f4d6b1e0d11ee8cc79dc2f83cfc6ff83b6dcd329dbfb40"
    JFROG_CLI_URL_ARM64 = "https://releases.jfrog.io/artifactory/jfrog-cli/v2-jf/2.57.0/jfrog-cli-linux-arm64/jf"
    JFROG_CLI_SHA256_ARM64 = "dc21a56c35e26e2d8447af7144367db2eba167b1db1d6740c0b7e3bb9042ef58"
    JFROG_CLI_URL_ARMHF = "https://releases.jfrog.io/artifactory/jfrog-cli/v2-jf/2.57.0/jfrog-cli-linux-arm/jf"
    JFROG_CLI_SHA256_ARMHF = "9b533670080f746b5c459644bd891afca081c5d938c453c2c4412d3350c7af98"
  }
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${VERSION}",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:latest",
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "JFrog CLI provides a simple interface that automates access to JFrog products."
    "org.opencontainers.image.title" = "${IMAGE_NAME}"
    "dev.polymathrobotics.image.readme-filepath" = "jfrog/jfrog-cli/README.md"
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
