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

## CLI

```
% docker run -it --rm \
  --env GITLAB_TOKEN \
  --mount type=bind,source="$(pwd)",target=/code \
  docker.io/polymathrobotics/glab
GLab is an open source GitLab CLI tool bringing GitLab to your command line

USAGE
  glab <command> <subcommand> [flags]

CORE COMMANDS
  alias:       Create, list and delete aliases
  api:         Make an authenticated request to GitLab API
  auth:        Manage glab's authentication state
  check-update: Check for latest glab releases
  ci:          Work with GitLab CI pipelines and jobs
  completion:  Generate shell completion scripts
  config:      Set and get glab settings
  help:        Help about any command
  issue:       Work with GitLab issues
  label:       Manage labels on remote
  mr:          Create, view and manage merge requests
  release:     Manage GitLab releases
  repo:        Work with GitLab repositories and projects
  ssh-key:     Manage SSH keys
  user:        Interact with user
  variable:    Manage GitLab Project and Group Variables
  version:     show glab version information

FLAGS
      --help      Show help for command
  -v, --version   show glab version information

ENVIRONMENT VARIABLES
  GITLAB_TOKEN: an authentication token for API requests. Setting this avoids being
  prompted to authenticate and overrides any previously stored credentials.
  Can be set in the config with 'glab config set token xxxxxx'

  GITLAB_HOST or GL_HOST: specify the url of the gitlab server if self hosted (eg: https://gitlab.example.com). Default is https://gitlab.com.

  REMOTE_ALIAS or GIT_REMOTE_URL_VAR: git remote variable or alias that contains the gitlab url.
  Can be set in the config with 'glab config set remote_alias origin'

  VISUAL, EDITOR (in order of precedence): the editor tool to use for authoring text.
  Can be set in the config with 'glab config set editor vim'

  BROWSER: the web browser to use for opening links.
  Can be set in the config with 'glab config set browser mybrowser'

  GLAMOUR_STYLE: environment variable to set your desired markdown renderer style
  Available options are (dark|light|notty) or set a custom style
  https://github.com/charmbracelet/glamour#styles

  NO_PROMPT: set to 1 (true) or 0 (false) to disable and enable prompts respectively

  NO_COLOR: set to any value to avoid printing ANSI escape sequences for color output.

  FORCE_HYPERLINKS: set to 1 to force hyperlinks to be output, even when not outputing to a TTY

  GLAB_CONFIG_DIR: set to a directory path to override the global configuration location

LEARN MORE
  Use 'glab <command> <subcommand> --help' for more information about a command.

FEEDBACK
  Encountered a bug or want to suggest a feature?
  Open an issue using 'glab issue create -R profclems/glab'
```

## Command examples

### Cloning a repo

```
$ glab repo clone profclems/glab

$ glab repo clone https://gitlab.com/profclems/glab

$ glab repo clone profclems/glab mydirectory  # Clones repo into mydirectory

$ glab repo clone glab   # clones repo glab for current user

$ glab repo clone 4356677   # finds the project by the ID provided and clones it

# Clone all repos in a group
$ glab repo clone -g everyonecancontribute
```

### Make an authenticated request to the api

GitLab REST API Docs: https://docs.gitlab.com/ce/api/README.html
GitLab GraphQL Docs: https://docs.gitlab.com/ee/api/graphql/

https://gitlab.com/polymathrobotics/customer_future_acres_bringup
https://gitlab.com/polymathrobotics/customer_future_acres_config
https://gitlab.com/polymathrobotics/customer_future_acres_description
https://gitlab.com/polymathrobotics/customer_future_acres_sim
https://gitlab.com/polymathrobotics/example_python_pkg
```
```
