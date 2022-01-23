This image contains the 1Password CLI.

Configuration cache prevents using this image as a command alias
================================================================
When the `op` command line tool runs, it persists tokens and other state
files to `$HOME/.op`.

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
FROM polymathrobotics/op-cli-amd64

COPY ./my-script.sh /home/opuser
RUN chmod +x ~/my-script.sh

ENTRYPOINT ~/my-script.sh
```


Also make sure you supply the UID and GID of the current user, otherwise
the config files will be created inside the image as root. Then on subsequent
runs, 1Password will complain that the files aren't readable.

```
$ docker container run -it --rm \
  -v $HOME/.op:/home/opuser/.op \
  --user $(id -u):$(id -g) \
  polymathrobotics/op-cli-amd64 /bin/bash
```
