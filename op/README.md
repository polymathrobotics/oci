# op

The 1Password command-line tool.

This image repackages the 1Password CLI releases from https://1password.com/downloads/command-line/

## Getting started with the command-line

Obtain a service account token or connect server token. Normally you will pipe the output
of the `op` command to tool to parse the machine-readable output, like `jq`. So, omit the
`--interactive` and `--tty` commands per https://github.com/moby/moby/issues/8513 to avoid
extra linefeeds being inserted into the output:

```
$ export OP_SERVICE_ACCOUNT_TOKEN=<service-account-token>
$ docker container run --rm \
    --env OP_SERVICE_ACCOUNT_TOKEN \
    docker.io/polymathrobotics/op whoami
```

Also, the 1Password CLI automatically-colourizes the machine-readable output produced
by several sub-commands (inserting ANSI control sequences depending on the platform),
so you may need to remove the escape sequences with the `--no-color` option:
```
$ docker container run --rm \
    --env OP_SERVICE_ACCOUNT_TOKEN \
    docker.io/polymathrobotics/op whoami --format=json --no-color
```

## Global CLI options

```
$ docker container run --rm \
    docker.io/polymathrobotics/op --help
1Password CLI provides commands to manage and
administer a 1Password account.

Sign in to an account to get started. Run 'op signin --help' to learn
more.

To learn more about 1Password CLI 2.0, check out our guides at
https://developer.1password.com

1Password CLI 2.0 is built using open source software, to view their
credits and licenses, visit:

https://downloads.1password.com/op/credits/stable/credits.html

CACHING

On UNIX-like systems, caching between commands is enabled by default
in 1Password CLI. This helps maximize performance and reduce
the number of API calls.

If you use 1Password CLI in an environment where caching is not
possible, you can turn it off by appending the "--cache=false"
flag to your commands, or by setting the "OP_CACHE" environment
variable to false.

Currently, caching is not available for Windows.

Usage:  op [command] [flags]

Management Commands:
  account     Manage your locally configured 1Password accounts
  connect     Manage Connect instances and Connect tokens in your 1Password account
  document    Perform CRUD operations on Document items in your vaults
  events-api  Manage Events API integrations in your 1Password account
  group       Manage the groups in your 1Password account
  item        Perform CRUD operations on the 1Password items in your vaults
  plugin      Manage the shell plugins you use to authenticate third-party CLIs
  ssh         Manage SSH keys
  user        Manage users within this 1Password account
  vault       Manage permissions and perform CRUD operations on your 1Password vaults

Commands:
  completion  Generate shell completion information
  inject      Inject secrets into a config file
  read        Read a secret using the secrets reference syntax
  run         Pass secrets as environment variables to a process
  signin      Sign in to a 1Password account
  signout     Sign out of a 1Password account
  update      Check for and download updates.
  whoami      Get information about a signed-in account

Global Flags:
      --account account    Select the account to execute the command by account shorthand, sign-in address, account ID, or user ID. For a list
                           of available accounts, run 'op account list'. Can be set as the OP_ACCOUNT environment variable.
      --cache              Store and use cached information. Cache is enabled by default. The cache is not available on Windows. (default true)
      --config directory   Use this configuration directory.
      --debug              Enable debug mode. Can also be enabled by setting the OP_DEBUG environment variable to true.
      --encoding type      Use this character encoding type. Default: UTF-8. Supported: SHIFT_JIS, gbk.
      --format string      Use this output format. Can be 'human-readable' or 'json'. Can be set as the OP_FORMAT environment variable.
                           (default "human-readable")
  -h, --help               Get help for op.
      --iso-timestamps     Format timestamps according to ISO 8601 / RFC 3339. Can be set as the OP_ISO_TIMESTAMPS environment variable.
      --no-color           Print output without color.
      --session token      Authenticate with this session token. 1Password CLI outputs session tokens for successful 'op signin' commands when
                           1Password app integration is not enabled.
  -v, --version            version for op

Run 'op [command] --help' for more information on the command.
```


Configuration cache prevents using this image as a command alias without a service account
==========================================================================================
When the `op` command line tool runs, it persists tokens and other state
files to `$HOME/.op`.

If you're not already running the 1password command line tools on your
host, make sure you create the `$HOME/.op` directory with the right
permissions:
```
# create the config directory owned by your UID and not root
mkdir $HOME/.op
# set the permissions so that it is not readable by others, this
# directory stores keys and other credentials
chmod 700 $HOME/.op
```

If you have an existing config on your host that you want to use in the
container image, you can bind mount the directory into the image:

```
docker run -it -v $HOME/.op:/home/opuser/.op polymathrobitcs/op-cli-amd64 /bin/bash
```

However, keep in mind that Docker writes new files inside the image as root.
So you will get all sorts of issues when the cache state files don't exist
on the host before running about them. The `op` program will complain that
the state files are invalid because they are owned by root. The 1Password
folks didn't really design their op command line tool to work very well
in a container standalone.

While there are some workarounds for this by passing in the UID/GID,
there are so many drawbacks and bugs around this in Docker when new files
are generated, it's not worth trying to make this work in Docker the
way it is right now. The user will still actually be $HOME-less - you'll
see `I have no name!` in the image. And the container also won't know about
the username:
https://medium.com/redbubble/running-a-docker-container-as-a-non-root-user-7d2e00f8ee15



So, if you plan on creating a script that uses op, or you want to use state
config files between container sessions, create a new container based on this
image. Don't bother trying to hack things to get the config written out as
another user besides root in the container image:

```
FROM polymathrobotics/op

COPY ./my-script.sh /home/op
RUN chmod +x ~/my-script.sh

ENTRYPOINT ~/my-script.sh
```

Make sure you supply the UID and GID of the current user, otherwise
the config files will be created inside the image as root. Then on subsequent
runs, 1Password will complain that the files aren't readable.

```
% docker container run --rm --interactive --tty \
    --mount type=bind,source="$HOME/.op",target="/home/opuser/.op" \
    --user $(id -u):$(id -g) \
    polymathrobotics/op:2 /bin/bash
```
