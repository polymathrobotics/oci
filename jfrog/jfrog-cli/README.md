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
docker container run -it --rm \
  --mount type=bind,source=$HOME/.jfrog,target=/home/jfrog/.jfrog \
  docker.io/polymathrobotics/jfrog-cli
```

You may also want to alias this "docker run" command in your shell to look
like it is being run as `jf`:
```
jf(){
  docker container run --rm \
    --mount type=bind,source=$HOME/.jfrog,target=/home/jfrog/.jfrog \
    --env JFROG_CLI_LOG_LEVEL=ERROR \
    docker.io/polymathrobotics/jfrog-cli "$@"
}
```

Subsequent examples will assume a similar alias is configured.

## Example usage

List all repositories:
```
$ jf rt curl --silent -XGET /api/repositories | jq '.[].key' -r
```

List all files in repo.
```
# Display a list of all artifacts located under /rabbit in the
# frog-repo repository.
$ JFROG_CLI_LOG_LEVEL=ERROR jf rt s 'frog-repo/rabbit/' | jq '.[].path' -r
```

File statistics. Supported by local and local-cached repositories
```
$ jf rt curl --silent -XGET '/api/storage/chef-cookbooks-local/versions.json?stats'
```
