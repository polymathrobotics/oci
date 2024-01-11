variable "IMAGE_NAME" {
  default = "ruby"
}

variable "VERSION" {
  default = "3.2.2"
}

variable "CONTAINER_REGISTRY" {
  default = "docker.io/polymathrobotics"
}

# There's no darwin-based Docker, so if we're running on macOS, change the platform to linux
variable "LOCAL_PLATFORM" {
  default = regex_replace("${BAKE_LOCAL_PLATFORM}", "^(darwin)", "linux")
}

target "_common" {
  args = {
    RUBY_VERSION = "${VERSION}"
    RUBY_DOWNLOAD_URL = "https://cache.ruby-lang.org/pub/ruby/3.3/ruby-3.3.0.tar.xz"
    RUBY_DOWNLOAD_SHA256 = "676b65a36e637e90f982b57b059189b3276b9045034dcd186a7e9078847b975b"
    RUSTUP_URL_AMD64 = "https://static.rust-lang.org/rustup/archive/1.26.0/x86_64-unknown-linux-gnu/rustup-init"
    RUSTUP_SHA256_AMD64 = "0b2f6c8f85a3d02fde2efc0ced4657869d73fccfce59defb4e8d29233116e6db"
    RUSTUP_URL_ARM64 = "https://static.rust-lang.org/rustup/archive/1.26.0/aarch64-unknown-linux-gnu/rustup-init"
    RUSTUP_SHA256_ARM64 = "673e336c81c65e6b16dcdede33f4cc9ed0f08bde1dbe7a935f113605292dc800"
    RUSTUP_INIT_DEFAULT_TOOLCHAIN = "1.74.1"
  }
  dockerfile = "Containerfile"
  tags = [
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:slim-jammy",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:3-slim-jammy",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${VERSION}-slim-jammy",
    "${CONTAINER_REGISTRY}/${IMAGE_NAME}:${join(".", slice(split(".", "${VERSION}"), 0, 2))}-slim-jammy",
  ]
  labels = {
    "org.opencontainers.image.source" = "https://github.com/polymathrobotics/oci"
    "org.opencontainers.image.licenses" = "Apache-2.0"
    "org.opencontainers.image.description" = "Ruby is a dynamic, reflective, object-oriented, general-purpose, open-source programming language."
    "org.opencontainers.image.title" = "${IMAGE_NAME}"
    "dev.polymathrobotics.image.readme-filepath" = "ruby/README.md"
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