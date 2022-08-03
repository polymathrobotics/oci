# Polymath Robotics Open Container Initiative (OCI) Images
Public container images published by Polymath Robotics.

The images are pubished to https://hub.docker.com/u/polymathrobotics

# Why are you re-publishing some official images?

Very few official images use Ubuntu 20.04 as a base image in their "FROM" field. These container images produced from this repository nearly all consistently use Ubuntu 20.04 as the base image, which is the preferred base for the Robot Operating System.

Because ROS uses Python heavily, it's not a good idea to use an alpine base image. It does not have a compatible C-runtime. And adding all the necessary C dependencies to an alpine image ironically makes it BIGGER than an equivalent Debian/Ubuntu image.

The official Debian images aren't nearly as good as a base for container images as the Ubuntu ones, because they are updated less frequently with security updates than the Ubuntu ones. Most Debian base images contain more security vulnerabilities than the equivalent Ubuntu ones, simply because they aren't updated as often. Also the commonly used "buildpack-deps" base images contain a lot of extra unused packages that aren't ever used in ROS, like the subversion, bzr and mercurial source control management programs to try to save space for a broader set of images. This unfortunately also increases the threat surface with a lot of extra packages we don't need, so we prefer not to use "buildpack-deps" where feasible.

It would be best to use Google's distroless images, but they are on the other end of the spectrum for dependencies, they don't include nearly enough. The Ubuntu images strike the best compromise in having most of the packages we need for ROS while not having too much we don't need.

# Building these container images locally

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
