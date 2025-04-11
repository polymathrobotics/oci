variable "TAG_PREFIX" {
  default = "docker.io/polymathrobotics/shfmt"
}

variable "VERSION" {
  default = "3.11.0"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  args = {
    SHFMT_URL_AMD64 = "https://github.com/mvdan/sh/releases/download/v3.11.0/shfmt_v3.11.0_linux_amd64"
    SHFMT_SHA256_AMD64 = "1904ec6bac715c1d05cd7f6612eec8f67a625c3749cb327e5bfb4127d09035ff"
    SHFMT_URL_ARM64 = "https://github.com/mvdan/sh/releases/download/v3.11.0/shfmt_v3.11.0_linux_arm64"
    SHFMT_SHA256_ARM64 = "b3976121710fd4b12bf641b0a7fb2686da598fb0da9f148c641b61b54cfa3407"
  }
  dockerfile = "Containerfile"
  tags = [
    "${TAG_PREFIX}:${VERSION}",
    "${TAG_PREFIX}:latest",
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "ShellCheck, a static analysis tool for shell scripts."
    "org.opencontainers.image.title" = "${TAG_PREFIX}"
    "org.opencontainers.image.created" = "${timestamp()}"
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
