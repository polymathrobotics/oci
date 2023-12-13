# ZED SDK

These images let you use the ZED SDK in a container image, even with the ZED
camera connected (or an SVO file)

Based on:
https://github.com/stereolabs/zed-docker/blob/master/4.X/l4t

## Jetson images

There are compatible images to run the ZED SDK in a container on the Nvidia Jetson.

Because the jetsons are usually limited in storage, there are a number of
variants are available to limit the disk space usage. OpenGL support is included
from the base image provided by Nvidia, and is available on all images.

- `runtime` images are the lightest and comes with every dependency installed. It's only meant to run applications linked with the ZED SDK.
- `devel` images contains all development tools to compile application including the cuda toolchain, static libraries, and headers of CUDA and the ZED SDK.
- `tools-devel` images include the tools and sample and the development tools similarly to devel image. It is the most complete and biggest image.
- `py-devel`  images contains all development tools to develop applications that uses ZED Python API.
- `py-runtime`  images are the lightest and comes with every dependency installed. It's only meant to run applications that uses the ZED Python API.

There is also an image for each version of "Linux for Tegra (L4T)". You should use
the version of l4t matching the version on the host machine. You can check the
version of l4t via `/etc/nv_tegra_release` like so:

```
$ cat /etc/nv_tegra_release
# R35 (release), REVISION: 3.1, GCID: 32827747, BOARD: t186ref, EABI: aarch64, DATE: Sun Mar 19 15:19:21 UTC 2023
```

Current images:

```bash
docker pull polymathrobotics/stereolabs-zed:4.0-devel-l4t-r35.3
docker pull polymathrobotics/stereolabs-zed:4.0-tools-devel-l4t-r35.3
docker pull polymathrobotics/stereolabs-zed:4.0-py-devel-l4t-r35.3
docker pull polymathrobotics/stereolabs-zed:4.0-runtime-l4t-r35.3
docker pull polymathrobotics/stereolabs-zed:4.0-py-runtime-l4t-r35.3

docker pull polymathrobotics/stereolabs-zed:4.0-devel-l4t-r35.4
docker pull polymathrobotics/stereolabs-zed:4.0-tools-devel-l4t-r35.4
docker pull polymathrobotics/stereolabs-zed:4.0-py-devel-l4t-r35.4
docker pull polymathrobotics/stereolabs-zed:4.0-runtime-l4t-r35.4
docker pull polymathrobotics/stereolabs-zed:4.0-py-runtime-l4t-r35.4
```