# pulumi

These images repackage releases from https://github.com/pulumi/pulumi-docker-containers:

- `pulumi-base`: A slim image that contains the Pulumi CLI, but no SDKs.
- `pulumi-python`: A slim image that contains the Pulumi CLI along with the Python runtime and Pulumi SDK.

## Using pulumi

The container's default `entrypoint` is the `pulumi` executable, but you'll usually want to provide additional command-line arguments in order to perform useful work, like:

- Environment variables, including a `PULUMI_ACCESS_TOKEN` and credentials for your cloud provider of choice 
- A mapping of the folder containing your Pulumi program into a folder in the container
- An `entrypoint` specifying whatever setup work should be performed before invoking `pulumi`, such as installing Node or Python dependencies.

For example, to run `pulumi preview` on a Python project targeting AWS:

```
docker container run -it --rm \
  -env PULUMI_ACCESS_TOKEN \
  -env AWS_ACCESS_KEY_ID \
  -env AWS_SECRET_ACCESS_KEY \
  -env AWS_REGION \
  --workdir /app \
  --mount type=bind,source="$(pwd)",target=/app \
  --entrypoint bash \
  docker.io/polymathrobotics/pulumi-python \
    -c "pip install -r requirements.txt && pulumi preview --stack dev --non-interactive"
```
