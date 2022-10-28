# glab

GLab is an open source GitLab CLI tool bringing GitLab to your terminal next to where you are already working with `git` and your code without switching between windows and browser tabs. Work with issues, merge requests, **watch running pipelines directly from your CLI** among other features.
Inspired by [gh], the official GitHub CLI tool.

This image packages releases from https://github.com/profclems/glab
NOTE: For the moment, we are packaging releases from https://github.com/profclems/glab because as of this writing, there are no releases (yet) on GitLab.

Image source: https://github.com/polymathrobotics/oci/tree/main/glab

## Using glab

You'll need to pass in a `GITLAB_TOKEN` for glab to use and mount your
source into the container:

```bash
docker run -it --rm \
  --env GITLAB_TOKEN \
  --mount type=bind,source="$(pwd)",target=/code \
  docker.io/polymathrobotics/glab <command>
```

You may also want to create an alias to the `glab` command in your
environment:

```
alias glab="docker run -it --rm --env GITLAB_TOKEN --mount type=bind,source="$(pwd)",target=/code docker.io/polymathrobotics/glab"
```

This will allow you to run glab comands using this image as if it were a local
install:
```
glab repo clone polymathrobotics/oci
```

## Authentication

You'll need to have a personal access token with at least the `api` and
`write_repository` scopes. You can run `glab auth login` to walk you through
the steps. glab will read the token via the `GITLAB_TOKEN` environment
variable. If you would prefer topass the token in via a file, you can use
`glab auth login --stdin < token.txt`.
