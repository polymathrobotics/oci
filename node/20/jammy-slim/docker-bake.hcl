variable "TAG_PREFIX" {
  default =  "docker.io/polymathrobotics/node"
}

variable "VERSION" {
  default = "20.17.0"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  dockerfile = "Containerfile"
  tags = [
    "${TAG_PREFIX}:${VERSION}-jammy-slim",
    "${TAG_PREFIX}:${join(".", slice(split(".", "${VERSION}"), 0, 2))}-jammy-slim",
    "${TAG_PREFIX}:${join(".", slice(split(".", "${VERSION}"), 0, 1))}-jammy-slim",
    "${TAG_PREFIX}:iron-jammy-slim",
    "${TAG_PREFIX}:lts-jammy-slim"
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/boxcutter/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "Digital Ocean command-line interface."
    "org.opencontainers.image.title" = "${TAG_PREFIX}"
    "org.opencontainers.image.created" = "${timestamp()}"
    "dev.polymathrobotics.image.readme-filepath" = "node/README.md"
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
