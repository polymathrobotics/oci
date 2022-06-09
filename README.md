# Polymath Robotics Open Container Initiative (OCI) Images
Public container images published by Polymath Robotics.

The images are pubished to https://hub.docker.com/u/polymathrobotics

Normally it is expected that you just use the GitHub Actions pipelines that have been configured in `.github/workflows`. However, the scripts to build the container images in the `/bin` subdirectory can be used to build any image locally on your machine. For example, to build `ros-core-amd64`:

```
# Make the current working directory the location of the Containerfile for the image you want to build
cd ros/ros-core-amd64
# Check the Containerfile with hadolint
$(git rev-parse --show-toplevel)/bin/lint.sh
# Build the image for testing locally (image name is configured in the `Polly.toml`)
$(git rev-parse --show-toplevel)/bin/buildx-build-local.sh
# Run tests on the image with cinc-auditor
$(git rev-parse --show-toplevel)/bin/buildx-test.sh
# (Optional) push the image to the container repository on dockerhub - ideally this should be done via a GitHub Actions workflow and not locally
$(git rev-parse --show-toplevel)/bin/buildx-build-push.sh
```
