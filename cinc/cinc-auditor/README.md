# cinc
CINC is a free, open source distribution of Chef. CINC is a recursive acronym - CINC is not Chef. These container images package all of the CINC projects.

## cinc-auditor

Cinc Auditor is built from Chef Inspec. Cinc Auditor is 100% compatible with its upstream Chef Inspec counterpart. It's the Chef equivalent of Ansible molecule, except that Inspec can be used separate from the Chef Configuration Management language/tooling. Chef Inspec is more generic and doesn't have a dependency on Chef - perfect for testing containers!

To run an inspec profile in order to test some infrastructure, just bind mount the source into `/share` like so:

```
% docker container run -it --rm \
  -v "$(pwd):/share" \
  polymathrobotics/cinc-auditor-amd64 exec .
```

If you need to run an inspec profile against a docker container image, make sure you start the other image first, sitting at a shell prompt, detached. Then also bind mount `/var/run/docker.sock` so the docker tools in the container work when you run cinc-auditor in a container:
```
# Easiest to save the container ID that is returned, as you'll need to destroy it.
# You could use a pre-defined name, but it should be unique so that it's possible to perform multiple cinc-auditor runs
# with the same image, so best to just use the returned container ID.
# We're using the nginx container image here as an example - you would typically use the name of some locally built image:
% CONTAINER_ID=$(docker container run --detach nginx)

# Verify the container is actually running with docker ps
% docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS     NAMES
dd6e9a9ce3df   nginx     "/docker-entrypoint.…"   14 seconds ago   Up 14 seconds   80/tcp    suspicious_shtern

# Run the inspec profile against the container ID - need to mount /var/run/docker.sock for the docker tools inside the
# container image to work
% docker container run -it --rm \
  -v "$(pwd):/share" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  polymathrobotics/cinc-auditor-arm64 exec . -t docker://${CONTAINER_ID}
  
# Stop the container under test - give a chance for PID 1 to clean up processes
% docker container stop ${CONTAINER_ID}
dd6e9a9ce3df1b6cf8164ed093da6fcd309d411f5a45ddcc2cbebb518de3ad40
# Fully clean up and remove the container image
% docker container remove ${CONTAINER_ID}
dd6e9a9ce3df1b6cf8164ed093da6fcd309d411f5a45ddcc2cbebb518de3ad40
```