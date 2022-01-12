# oci
This repo is used to build the commonly used docker container images at Polymath Robotics. Currently these images are published to https://hub.docker.com/u/polymathrobotics.

Normally it is expected that you just use the GitHub Actions pipelines that have been configured in `.github/workflows`. However, the scripts to build the container images in the `/bin` subdirectory can be used to build any image locally on your machine. For example, to build `ros-core-amd64`:

```
# Make the current working directory the location of the Containerfile for the image you want to build
cd ros/ros-core-amd64
# Build the image with the default tag (image name is configured in the IMAGE_NAME file)
$(git rev-parse --show-toplevel)/bin/build.sh
# Tag the image with additional tags defined in the TAGS file
$(git rev-parse --show-toplevel)/bin/tag.sh
# (Optional) push the image to the container repository on dockerhub - ideally this should be done via a GitHub Actions workflow and not locally
$(git rev-parse --show-toplevel)/bin/tag.sh
```
