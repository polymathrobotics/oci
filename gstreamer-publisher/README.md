# gstreamer-publisher

`gstreamer-publisher` publishes video and audio from a GStreamer pipeline to
LiveKit.

This image builds pinned revisions from
https://github.com/livekit/gstreamer-publisher

Image source: https://github.com/polymathrobotics/oci/tree/main/gstreamer-publisher

Use the `jammy` tag for ROS Humble-compatible builds and `noble` for newer ROS
distributions.

```bash
docker container run --rm \
  docker.io/polymathrobotics/gstreamer-publisher:jammy --help
```
