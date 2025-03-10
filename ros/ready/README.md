# ROS 2-Ready Base Images

This directory creates minimized base images that are "ready to receive ROS 2", but don't yet have any packages installed.

These targets are produced:

- ["ready"](#ready)
- ["builder"](#builder)

## Ready

Tag: `polymathrobotics/ros:${ROS_DISTRO}-ready-ubuntu`

This image is simply fully prepared to install packages for the given ROS 2 distribution without any extra setup.

It has no build tools, and _no_ ROS 2 packages actually installed.

Use case: A basis for a runtime deployment image, with a built application installed in it and ready to run.

## Builder

Tag: `polymathrobotics/ros:${ROS_DISTRO}-builder-ubuntu`

Builds on top of `ready`.

This image has the common ROS build tools installed, but still _no_ ROS packages.

It is ready to receive a colcon source workspace, install its dependencies, then build it.

Use case: CI and development environments.


## Usage Patterns

The following `Containerfile` is optimized to get a builder prepared to build your workspace, with exactly its dependencies installed

```containerfile
ARG TARGET=builder
ARG ROS_DISTRO=humble
FROM docker.io/polymathrobotics/ros:${ROS_DISTRO}-${TARGET}-ubuntu AS base

ARG COLCON_SRC=src
ARG ROSDEP_SKIP_KEYS=""

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

####################
# Rosdep Cache Layer
# Prevents cache invalidation when sources change but dependency list does not
####################
FROM base AS depcache

ARG COLCON_SRC
ARG ROSDEP_SKIP_KEYS

ENV SKIP_KEYS=${ROSDEP_SKIP_KEYS}

# create file install_rosdeps.sh that won't change and bust cache if no dependencies change
RUN --mount=type=bind,source=${COLCON_SRC},target=/tmp/src \
    rosdep update \
 && gather-rosdeps /tmp/install_rosdeps.sh /tmp/src

#################
# Workspace Layer: Installs dependencies to create a workspace ready to build your application
#################
FROM base AS workspace

COPY --from=depcache /tmp/install_rosdeps.sh /tmp/install_rosdeps.sh
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update \
 && cat /tmp/install_rosdeps.sh \
 && /tmp/install_rosdeps.sh \
 && rm -rf /var/lib/apt/lists/*
```


Example usage:

```bash
$ cd my_application_workspace
$ ls -1F
Containerfile
src/

# Create the prepared workspace builder with all dependencies installed
$ docker build . \
  -f Containerfile \
  --build-arg TARGET=builder \
  --build-arg ROS_DISTRO=humble \
  --build-arg COLCON_SRC=src \
  -t my_application:humble-builder

# Run a noninteractive build
$ docker run \
  -v $(pwd):/ros_workspace \
  -w /ros_workspace \
  my_application:humble-builder \
  /bin/bash -c "source /opt/ros/humble/setup.bash && colcon build"


# Or, you can run an interactive session within the container for development
$ docker run -v $(pwd):/ros_workspace -w /ros_workspace -it my_application:humble-builder
```
