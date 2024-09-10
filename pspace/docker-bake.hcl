variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/pspace"
}

variable "VERSION" {
  default = "1.10.1"
}

target "_common" {
  dockerfile = "Containerfile"
  args = {
    CLI_URL_AMD64 = "https://github.com/Paperspace/cli/releases/download/1.10.1/pspace-linux.zip"
  }
  tags = [
    "${TAG_PREFIX}:${VERSION}",
    "${TAG_PREFIX}:latest",
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "GPL-2.0"
    "org.opencontainers.image.description" = "Command line tool used to perform many tasks related to computer management of Intel Active Management Technology (AMT) devices."
    "org.opencontainers.image.title" = "${TAG_PREFIX}"
    "org.opencontainers.image.created" = "${timestamp()}"
  }
}

target "default" {
  inherits = ["_common"]
  platforms = ["linux/amd64"]
}

target "local" {
  inherits = ["_common"]
  platforms = ["linux/amd64"]
}
