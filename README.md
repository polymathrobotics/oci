# Polymath Robotics Open Container Initiative (OCI) Images [![oci](https://github.com/polymathrobotics/oci/actions/workflows/ci.yml/badge.svg)](https://github.com/polymathrobotics/oci/actions/workflows/ci.yml)
Public container images published by Polymath Robotics.

The images are pubished to https://hub.docker.com/u/polymathrobotics

# Alphabetical index of images

| Image | Description | Source Location |
| --- | --- | --- |
| [aws-cli](https://hub.docker.com/r/polymathrobotics/aws-cli) | Command-line interface v2 for Amazon Web Services | [aws-cli](https://github.com/polymathrobotics/oci/blob/main/aws-cli) |
| [black](https://hub.docker.com/r/polymathrobotics/black) | The uncompromising Python code formatter | [black](https://github.com/polymathrobotics/oci/tree/main/black) |
| [buildpack-deps](https://hub.docker.com/r/polymathrobotics/buildpack-deps) | A collection of common build dependencies used for installing various modules, e.g., gems | [buildpack-deps](https://github.com/polymathrobotics/oci/tree/main/buildpack-deps) |
| [certbot](https://hub.docker.com/r/polymathrobotics/certbot)<br>[certbot-dns-cloudflare](https://hub.docker.com/r/polymathrobotics/certbot-dns-cloudflare)<br>[lego](https://hub.docker.com/r/polymathrobotics/lego) | Automatic Certificate Management Environment (ACME) clients for obtaining SSL/TLS certificates. | [acme/certbot](https://github.com/polymathrobotics/oci/tree/main/acme/certbot)<br>[acme/certbot-dns-cloudflare](https://github.com/polymathrobotics/oci/tree/main/acme/certbot-dns-cloudflare)<br>[lego](https://github.com/polymathrobotics/oci/tree/main/acme/lego) |
| [cinc-auditor](https://hub.docker.com/r/polymathrobotics/cinc-auditor)<br>[cinc-workstation](https://hub.docker.com/r/polymathrobotics/cinc-workstation) | Cinc is an automation platform built from Chef | [cinc/cinc-auditor](https://github.com/polymathrobotics/oci/tree/main/cinc/cinc-auditor)<br>[cinc/cinc-workstation](https://github.com/polymathrobotics/oci/tree/main/cinc/cinc-workstation) |
| [doctl](https://hub.docker.com/r/polymathrobotics/doctl) | Command line interface for the DigitalOcean cloud | [doctl](https://github.com/polymathrobotics/oci/tree/main/doctl) |
| [cinc](https://hub.docker.com/r/polymathrobotics/cinc)<br>[dokken-almalinux-8](https://hub.docker.com/r/polymathrobotics/dokken-almalinux-8)<br>[dokken-almalinux-9](https://hub.docker.com/r/polymathrobotics/dokken-almalinux-9)<br>[dokken-amazonlinux-2](https://hub.docker.com/r/polymathrobotics/dokken-amazonlinux-2)<br>[dokken-amazonlinux-2023](https://hub.docker.com/r/polymathrobotics/dokken-amazonlinux-2023)<br>[dokken-centos-stream-8](https://hub.docker.com/r/polymathrobotics/dokken-centos-stream-8)<br>[dokken-centos-stream-9](https://hub.docker.com/r/polymathrobotics/dokken-centos-stream-9)<br>[dokken-debian-11](https://hub.docker.com/r/polymathrobotics/dokken-debian-11)<br>[dokken-debian-12](https://hub.docker.com/r/polymathrobotics/dokken-debian-12)<br>[dokken-opensuse-leap-15.3](https://hub.docker.com/r/polymathrobotics/dokken-opensuse-leap-15.3)<br>[dokken-opensuse-leap-15.4](https://hub.docker.com/r/polymathrobotics/dokken-opensuse-leap-15.4)<br>[dokken-oraclelinux-8](https://hub.docker.com/r/polymathrobotics/dokken-oraclelinux-8)<br>[dokken-oraclelinux-9](https://hub.docker.com/r/polymathrobotics/dokken-oraclelinux-9)<br>[dokken-rockylinux-8](https://hub.docker.com/r/polymathrobotics/dokken-rockylinux-8)<br>[dokken-rockylinux-9](https://hub.docker.com/r/polymathrobotics/dokken-rockylinux-9)<br>[dokken-ubuntu-20.04](https://hub.docker.com/r/polymathrobotics/dokken-ubuntu-20.04)<br>[dokken-ubuntu-22.04](https://hub.docker.com/r/polymathrobotics/dokken-ubuntu-22.04) | Operating system images for use with the kitchen-dokken Test Kitchen plugin  | [cinc](https://github.com/polymathrobotics/oci/tree/main/dokken/cinc)<br>[dokken-almalinux-8](https://github.com/polymathrobotics/oci/tree/main/dokken/almalinux-8)<br>[dokken-almalinux-9](https://github.com/polymathrobotics/oci/tree/main/dokken/almalinux-9)<br>[dokken-amazonlinux-2](https://github.com/polymathrobotics/oci/tree/main/dokken/amazonlinux-2)<br>[dokken-amazonlinux-2023](https://github.com/polymathrobotics/oci/tree/main/dokken/amazonlinux-2023)<br>[dokken-centos-stream-8](https://github.com/polymathrobotics/oci/tree/main/dokken/centos-stream-8)<br>[dokken-centos-stream-9](https://github.com/polymathrobotics/oci/tree/main/dokken/centos-stream-9)<br>[dokken-debian-11](https://github.com/polymathrobotics/oci/tree/main/dokken/debian-11)<br>[dokken-debian-12](https://github.com/polymathrobotics/oci/tree/main/dokken/debian-12)<br>[dokken-opensuse-leap-15.3](https://github.com/polymathrobotics/oci/tree/main/dokken/opensuse-leap-15.3)<br>[dokken-opensuse-leap-15.4](https://github.com/polymathrobotics/oci/tree/main/dokken/opensuse-leap-15.4)<br>[dokken-oraclelinux-8](https://github.com/polymathrobotics/oci/tree/main/dokken/oraclelinux-8)<br>[dokken-oraclelinux-9](https://github.com/polymathrobotics/oci/tree/main/dokken/oraclelinux-9)<br>[dokken-rockylinux-8](https://github.com/polymathrobotics/oci/tree/main/dokken/rockylinux-8)<br>[dokken-rockylinux-9](https://github.com/polymathrobotics/oci/tree/main/dokken/rockylinux-9)<br>[dokken-ubuntu-20.04](https://github.com/polymathrobotics/oci/tree/main/dokken/ubuntu-20.04)<br>[dokken-ubuntu-22.04](https://github.com/polymathrobotics/oci/tree/main/dokken/ubuntu-22.04) |
| [flake8](https://hub.docker.com/r/polymathrobotics/flake8) | flake8 is a python tool that glues together pycodestyle, pyflakes, mccabe, and third-party plugins to check the style and quality of some python code | [flake8](https://github.com/polymathrobotics/oci/tree/main/flake8) |
| [gh](https://hub.docker.com/r/polymathrobotics/gh) | The GitHub CLI tool | [github-cli](https://github.com/polymathrobotics/oci/tree/main/github-cli) |
| [glab](https://hub.docker.com/r/polymathrobotics/glab) | The GitLab CLI tool | [glab](https://github.com/polymathrobotics/oci/tree/main/glab) |
| [go2chef](https://hub.docker.com/r/polymathrobotics/go2chef) | A Golang tool to bootstrap a system from zero so that it's able to run Chef | [go2chef](https://github.com/polymathrobotics/oci/tree/main/go2chef) |
| [golang](https://hub.docker.com/r/polymathrobotics/golang) | Go (golang) is a general purpose, higher-level, imperative programming language. | [golang](https://github.com/polymathrobotics/oci/tree/main/golang) |
| [grafana-oss](https://hub.docker.com/r/polymathrobotics/grafana-oss) | Grafana - the open observability platform | [grafana/grafana-oss](https://github.com/polymathrobotics/oci/tree/main/grafana/grafana-oss) |
| [hadolint](https://hub.docker.com/r/polymathrobotics/hadolint) | Containerfile/Dockerfile linter | [hadolint](https://github.com/polymathrobotics/oci/tree/main/hadolint) |
| [jfrog-cli](https://hub.docker.com/r/polymathrobotics/jfrog-cli) | JFrog CLI provides a simple interface that automates access to JFrog products. | [jfrog-cli](https://github.com/polymathrobotics/oci/tree/main/jfrog/jfrog-cli) |
| [ldap-utils](https://hub.docker.com/r/polymathrobotics/ldap-utils) | OpenLDAP client utilities. | [ldap-utils](https://github.com/polymathrobotics/oci/tree/main/ldap-utils) |
| [lego](https://hub.docker.com/r/polymathrobotics/lego) | Let's Encrypt/ACME client and library written in Go. | [acme/lego](https://github.com/polymathrobotics/oci/tree/main/acme/lego) |
| [markdownlint](https://hub.docker.com/r/polymathrobotics/markdownlint) | A tool to check markdown files and flag style issues | [markdownlint](https://github.com/polymathrobotics/oci/tree/main/markdownlint) |
| [meshcmd](https://hub.docker.com/r/polymathrobotics/meshcmd) | Command line tool used to perform many tasks related to computer management of Intel Active Management Technology (AMT) devices | [meshcmd](https://github.com/polymathrobotics/oci/tree/main/meshcmd) |
| [netbox](https://hub.docker.com/r/polymathrobotics/netbox) | Repository for modeling and documenting networks. | [node](https://github.com/polymathrobotics/oci/tree/main/netbox) |
| [node](https://hub.docker.com/r/polymathrobotics/node) | Node.js is a JavaScript-based platform for server-side and networking applications. | [node](https://github.com/polymathrobotics/oci/tree/main/node) |
| [nvidia-l4t-base](https://hub.docker.com/r/polymathrobotics/nvidia-l4t-base)<br>[nvidia-l4t-jetpack](https://hub.docker.com/r/polymathrobotics/nvidia-l4t-jetpack)<br>[nvidia-l4t-ros](https://hub.docker.com/r/polymathrobotics/nvidia-l4t-ros) | NVIDIA L4T is a Linux based software distribution for the NVIDIA Jetson embedded computing platform. | [nvidia/l4t-base](https://github.com/polymathrobotics/oci/tree/main/nvidia/l4t-base)<br>[nvidia-l4t-jetpack](https://github.com/polymathrobotics/oci/tree/main/nvidia/l4t-jetpack)<br>[nvidia-l4t-ros](https://github.com/polymathrobotics/oci/tree/main/nvidia/l4t-ros) |
| [op](https://hub.docker.com/r/polymathrobotics/op) | 1Password command-line interface 2 | [op](https://github.com/polymathrobotics/oci/tree/main/op) |
| [paperspace-cli](https://hub.docker.com/r/polymathrobotics/paperspace-cli) | Command-line interface for the Paperspace cloud | [paperspace-cli](https://github.com/polymathrobotics/oci/tree/main/paperspace-cli) |
| [portainer-ce](https://hub.docker.com/r/polymathrobotics/portainer-ce) | ortainer Community Edition GUI-based container management platform. | [portainer-ce](https://github.com/polymathrobotics/oci/tree/main/portainer-ce) |
| [postgres](https://hub.docker.com/r/polymathrobotics/postgres) | The PostgreSQL object-relational database system provides reliability and data integrity | [postgres](https://github.com/polymathrobotics/oci/tree/main/postgres) |
| [prometheus](https://hub.docker.com/r/polymathrobotics/prometheus)<br>[alertmanager](https://hub.docker.com/r/polymathrobotics/alertmanager)<br>[blackbox_exporter](https://hub.docker.com/r/polymathrobotics/blackbox_exporter)<br>[collectd_exporter](https://hub.docker.com/r/polymathrobotics/collectd_exporter)<br>[node_exporter](https://hub.docker.com/r/polymathrobotics/node_exporter) | Prometheus monitoring system and time series database | [prometheus/prometheus](https://github.com/polymathrobotics/oci/tree/main/prometheus/prometheus)<br>[prometheus/alertmanager](https://github.com/polymathrobotics/oci/tree/main/prometheus/alertmanager)<br>[prometheus/blackbox_exporter](https://github.com/polymathrobotics/oci/tree/main/prometheus/blackbox_exporter)<br>[prometheus/collectd_exporter](https://github.com/polymathrobotics/oci/tree/main/prometheus/collectd_exporter)<br>[prometheus/node_exporter](https://github.com/polymathrobotics/oci/tree/main/prometheus/node_exporter) |
| [pulumi-base](https://hub.docker.com/r/polymathrobotics/pulumi-base)<br>[pulumi-python](https://hub.docker.com/r/polymathrobotics/pulumi-python) | Pulumi Infrastructure as Code CLI | [pulumi-base](https://github.com/polymathrobotics/oci/tree/main/pulumi/pulumi-base)<br>[pulumi-python](https://github.com/polymathrobotics/oci/tree/main/pulumi/pulumi-python) |
| [python](https://hub.docker.com/r/polymathrobotics/python) | The Python programming language | [python](https://github.com/polymathrobotics/oci/tree/main/python) |
| [redis](https://hub.docker.com/r/polymathrobotics/redis) | Redis is an open source key-value store that functions as a data structure server. | [redis](https://github.com/polymathrobotics/oci/tree/main/redis) |
| [ros](https://hub.docker.com/r/polymathrobotics/ros) | The Robot Operating System | [humble-jammy](https://github.com/polymathrobotics/oci/tree/main/ros/humble/ubuntu/jammy)<br>[iron-jammy](https://github.com/polymathrobotics/oci/tree/main/ros/iron/ubuntu/jammy)<br>[noetic-focal](https://github.com/polymathrobotics/oci/tree/main/ros/noetic/ubuntu/focal)<br>[rolling-jammy](https://github.com/polymathrobotics/oci/tree/main/ros/rolling/ubuntu/jammy) |
| [ruby](https://hub.docker.com/r/polymathrobotics/ruby) | Ruby is a dynamic, reflective, object-oriented, general-purpose, open-source programming language | [ruby](https://github.com/polymathrobotics/oci/tree/main/ruby) |
| [shellcheck](https://hub.docker.com/r/polymathrobotics/shellcheck) | Static analysis tool for shell scripts | [shellcheck](https://github.com/polymathrobotics/oci/tree/main/shellcheck) |
| [smokeping](https://hub.docker.com/r/polymathrobotics/smokeping) | Smokeping network latency grapher | [smokeping](https://github.com/polymathrobotics/oci/tree/main/smokeping) |
| [stereolabs-zed](https://hub.docker.com/r/polymathrobotics/stereolabs-zed)<br>[stereolabs-zedbot](https://hub.docker.com/r/polymathrobotics/stereolabs-zedbot) | StereoLabs ZED SDK | [stereolabs-zed](https://github.com/polymathrobotics/oci/tree/main/stereolabs/zed)<br>[stereolabs-zedbot](https://github.com/polymathrobotics/oci/tree/main/stereolabs/zedbot) |
| [terraform](https://hub.docker.com/r/polymathrobotics/terraform) | Terraform enables you to safely and predictably create, change, and improve infrastructure. | [terraform](https://github.com/polymathrobotics/oci/tree/main/hashicorp/terraform) |
| [ubuntu-autoinstall](https://hub.docker.com/r/polymathrobotics/ubuntu-autoinstall) | Generate Ubuntu autoinstall images/ISOs. | [ubuntu-autoinstall](https://github.com/polymathrobotics/oci/tree/main/ubuntu-autoinstall) |

# Why are you re-publishing some official images?

Re-packaging is a time-honored trend in system administration! It's not as common as you might think to use a vanilla install
to manage a fleet of servers. Software installs often need to be re-packaged and re-mixed for a specific purpose. In our
case for robotics, neuromorphic engineering, systems and embedded applications.

It's not as consistent as one would hope to allow a rootless deploy of some official images. In some cases we need to re-mix
a container image for that reason.

For embedded and systems work, we need images built for a variety of processors, not all official images provide builds even
for intel, arm64 and arm32 chips. So we try as much as we can for a wider variety of platforms.

Very few official images use Ubuntu as a base image in their "FROM" field. The container images produced from this repository
nearly all consistently use Ubuntu as the base image, which is the preferred base for the Robot Operating System (ROS).

Because ROS uses Python heavily, it's not a good idea to use an alpine base image. It does not have
a compatible C-runtime. And adding all the necessary C dependencies to an alpine image ironically makes it BIGGER than an
equivalent Debian/Ubuntu image.

The official Debian images aren't nearly as good as a base for container images as the Ubuntu ones, because they are updated
less frequently with security updates than the Ubuntu ones. Most Debian base images contain more security vulnerabilities
than the equivalent Ubuntu ones, simply because they aren't updated as often. Also the commonly used "buildpack-deps" base
images contain a lot of extra unused packages that aren't ever used in ROS, like the subversion, bzr and mercurial source
control management programs to try to save space for a broader set of images. This unfortunately also increases the threat
surface with a lot of extra packages we don't need, so we prefer not to use "buildpack-deps" where feasible.

It would be best to use Google's distroless images, but they are on the other end of the spectrum for dependencies, they
don't include nearly enough. The Ubuntu images strike the best compromise in having most of the packages we need for ROS
while not having too much that we don't need.

# Navigating

The repo has the following structure:

- `bin/` contains supporting scripts used to create container images. This
  allows maintainers to more easily run parts of the build locally for
  troubleshooting. The build system shells out to the same scripts so
  everything uses the same code, whether or not you are building locally or
  using automated builds in the cloud.

- Rest of the directories contain all the source code for the images, primarily
  Containerfiles/Dockerfiles in BuildKit format. An alphabetical
  index is also provided in this README.md.
  
# Developing

Following container image conventions there is a separate directory for each container image. The container image
tools have a single target directory for source files and by default the image tools scan all files in a directory
for some operations. Thus there is a subdirectory per image, though a single image may be built for multiple
platforms. The source for all the container images is under the `src/` tree in this repo. GitHub Actions pipelines
in `.github/workflows` have been set up to publish these images to the 
[polymathrobotics org](https://hub.docker.com/u/polymathrobotics) on DockerHub.

Since container image source code packaging is small, for convenience all the source is together in one big repo.
There is an alphabetical index for all the images below.

When a new image is added, the base directory is added to the list of directories in `.github/workflows/ci.yml`.
There's a rule that fires a build for each image only when a particular directory contents are changed.

Each source directory has a similar basic structure. The image directory is not required to be at any particular
level in the directory hieararchy. Some of images have are grouped vendor or application type.

```
├── <image name>
│   ├── .dockerignore
│   ├── Containerfile
│   ├── docker-bake.hcl
│   ├── README.md
│   ├── test
│   │   ├── controls
│   │   │   ├── <inspec *.rb files>
```

The files are as follows:
- `.dockerignore` - standard .dockerignore, list of files that should be ignored during a build to increase
  performance.
- `Containerfile` - a file using the Dockerfile DSL that includes commands for building an image. We process
  Containerfiles with BuildKit and encourge image authors to make use of BuildKit-specific features in
  image builds.
- `docker-bake.hcl` - A Docker Bake file that builds the image with docker buildx bake.
- `test/` - subdirectory containing a Chef InSpec profile with tests for the contaimer image.

## Building these container images locally

Normally we just use the GitHub Actions pipelines that have been configured in `.github/workflows` to build
these images. However, the scripts to build the container images in the `/bin` subdirectory can be used to
build any image locally on your machine. For example, to build `ros-core`:

```bash
# Make the current working directory the location of the Containerfile for the image you want to build
cd ros/ros-core
# Check the Containerfile with hadolint
$(git rev-parse --show-toplevel)/bin/lint.sh
# Build the image for testing on the local processor architecture
docker buildx create --use
docker buildx bake local --local
# Run tests on the image with cinc-auditor
$(git rev-parse --show-toplevel)/bin/test-matrix.sh
# (Optional) build and push the image to the container repository on dockerhub - ideally this should be done via a GitHub Actions workflow and not locally
docker buildx bake default --push
```
