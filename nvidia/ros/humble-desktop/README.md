Based on:
- https://github.com/dusty-nv/jetson-containers

```
sudo xhost +si:localuser:root

sudo docker run -it --rm \
  --runtime nvidia \
  --network host \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix/:/tmp/.X11-unix \
  docker.io/polymathrobotics/ros:humble-ros-core-l4t-r35.4.1
```
