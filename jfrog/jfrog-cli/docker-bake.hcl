variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/jfrog-cli"
}

variable "VERSION" {
  default = "2.66.0"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  dockerfile = "Containerfile"
  args = {
    JFROG_CLI_VERSION = "${VERSION}"
    JFROG_CLI_URL_AMD64 = "https://releases.jfrog.io/artifactory/jfrog-cli/v2-jf/2.66.0/jfrog-cli-linux-amd64/jf"
    JFROG_CLI_SHA256_AMD64 = "b3c92f70b75e7b05948ef70f015511928b986bd04ed60d90bb2fedcc62f1ea02"
    JFROG_CLI_URL_ARM64 = "https://releases.jfrog.io/artifactory/jfrog-cli/v2-jf/2.66.0/jfrog-cli-linux-arm64/jf"
    JFROG_CLI_SHA256_ARM64 = "e79029dcc26be5ce8fd32409a24e63d8ed5442e7fe0d375e5e5c8f17d44dd7a1"
  }
  tags = [
    "${TAG_PREFIX}:${VERSION}",
    "${TAG_PREFIX}:latest",
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "JFrog CLI provides a simple interface that automates access to JFrog products."
    "org.opencontainers.image.title" = "${TAG_PREFIX}"
    "org.opencontainers.image.created" = "${timestamp()}"
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
