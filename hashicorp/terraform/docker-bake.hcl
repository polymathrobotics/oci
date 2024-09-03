variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/terraform"
}

variable "VERSION" {
  default = "1.9.5"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  args = {
    TERRAFORM_URL_AMD64 = "https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_amd64.zip"
    TERRAFORM_SHA256_AMD64 = "9cf727b4d6bd2d4d2908f08bd282f9e4809d6c3071c3b8ebe53558bee6dc913b"
    TERRAFORM_URL_ARM64 = "https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_arm64.zip"
    TERRAFORM_SHA256_ARM64 = "adb3206971bc73fd37c7b50399ef79fe5610b03d3f2d1783d91e119422a113fd"
  }
  dockerfile = "Containerfile"
  tags = [
    "${TAG_PREFIX}:${VERSION}",
    "${TAG_PREFIX}:latest",
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "MPL 2.0"
    "org.opencontainers.image.description" = "Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently."
    "org.opencontainers.image.title" = "${TAG_PREFIX}"
    "org.opencontainers.image.created" = "${timestamp()}"
    "dev.polymathrobotics.image.readme-filepath" = "hashicorp/terraform/README.md"
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