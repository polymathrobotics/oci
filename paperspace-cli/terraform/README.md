# terraform

Paperspace has a Terraform provider:
https://github.com/Paperspace/terraform-provider-paperspace/blob/master/README.md

There's not much in the way on docs for its use besides the source code
and some examples provided:
https://github.com/Paperspace/terraform-provider-paperspace/tree/master/pkg/provider

However, the gradient installer uses the terraform provider and includes some
more useful examples:
https://github.com/Paperspace/gradient-installer/tree/master/gradient-ps-cloud

## Using this Terraform example to spin up an instance

```
% cd example
% docker run -it --rm \
  --env PAPERSPACE_API_KEY \
  --mount type=bind,source="$(pwd)",target=/terraform \
  --entrypoint /bin/bash \
  docker.io/polymathrobotics/terraform
# terraform init
# terraform plan
# terraform apply
# terraform output
# exit
```
