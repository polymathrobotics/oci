# jfrog-cli

JFrog CLI is a compact and smart client that provides a simple interface that
automates access to JFrog products simplifying your automation scripts and
making them more readable and easier to maintain. JFrog CLI works with JFrog
Artifactory, Xray, Distribution and Pipelines (through their respective REST
APIs) making your scripts more efficient and reliable.

For more information, refer to the official docs via
https://docs.jfrog-applications.jfrog.io/jfrog-applications/jfrog-cli

Based on:
- releases-docker.jfrog.io/jfrog/jfrog-cli-v2-jf

To use the JFrog CLI with your host machine's existing config (or to persist
configuration after the container exits):

```
docker run -it --rm \
  --mount type=bind,source=$HOME/.jfrog,target=/home/jfrog/.jfrog \
  docker.io/polymathrobotics/jfrog-cli
```
