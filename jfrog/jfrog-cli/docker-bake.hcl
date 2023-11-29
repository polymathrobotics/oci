variable "IMAGE_NAME" {
  default = "jfrog-cli"
}

variable "VERSION" {
  default = "2.50.2"
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
    JFROG_CLI_URL_AMD64 = "https://releases.jfrog.io/artifactory/jfrog-cli/v2-jf/2.50.2/jfrog-cli-linux-amd64/jf"
    JFROG_CLI_SHA256_AMD64 = "e033c79dbdd60538df1b0b5fb139c8bc5698fbdf86024b2a41620c31eedab1d2"
    JFROG_CLI_URL_ARM64 = "https://releases.jfrog.io/artifactory/jfrog-cli/v2-jf/2.50.2/jfrog-cli-linux-arm64/jf"
    JFROG_CLI_SHA256_ARM64 = "d64c92e74cad6fa7fa5deb70a1c511bd37005cf8d2fa1ded6605d4c7cd19041c"
    JFROG_CLI_URL_ARMHF = "https://releases.jfrog.io/artifactory/jfrog-cli/v2-jf/2.50.2/jfrog-cli-linux-arm/jf"
    JFROG_CLI_SHA256_ARMHF = "a3bf926edb350dc52a20391496816212147720f9a15edae9c773b2e0fc64a249"
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