Obtain a [Paperspace API Key](docs/PAPERSPACE_API_KEY.md).

For more information on the API, refer to https://github.com/Paperspace/paperspace-node for more
details.

The Paperspace-Node module looks for the api key:
- PAPERSPACE_API_KEY

There are `login` and `logout` commands, but they currently don't do
anything. You must pass in the api key via the `--apiKey` parameter
or with this environment variable.

You can generate an API Keys by going to "My Account > Team settings"
then click on the "API Keys" tab.

Many commands require user input, so it is recommended to pass the 
`--interactive` and `--tty` flags as well:

Listing machine types
```
docker run --rm \
  --env=PAPERSPACE_API_KEY \
  polymathrobotics/paperspace-cli paperspace jobs machineTypes | less
```
  
Listing templates
```
docker run --rm \
  --env=PAPERSPACE_API_KEY \
  polymathrobotics/paperspace-cli paperspace templates list | less
```

Creating a machine:

Valid entries for `region`:
- `West Coast (CA1)`
- `East Coast (NY2)`
- `Europe (AMS1)`

https://support.paperspace.com/hc/en-us/articles/234711428-Machine-Pricing

Valid entries for `machineType`:
- `C1`, `C2`, `C3`, `C4`, `C5`, `C6`, `C7`, `C8`, `C9`, `C10`
- `Air`
- `Standard`
- `Pro`
- `Advanced`
- `GPU+`
- `P4000`, `P5000`, `P6000`, `V100`

Valid entries for `billingType`:
- `monthly`
- `hourly`

```
docker run --rm --interactive --tty \
  --env=PAPERSPACE_API_KEY \
  polymathrobotics/paperspace-cli paperspace machines create \
    --machineName "Testy" \
    --region "East Coast (NY2)" \
    --machineType "C1" \
    --size 50 \
    --billingType "hourly" \
    --templateId "tkni3aa4" \
    --teamId "t21p7hla3g" \
    --assignPublicIp true \
    --startOnCreate true

PAPERSPACE_MACHINE_ID=$(docker run --rm --tty \
  --env=PAPERSPACE_API_KEY \
  polymathrobotics/paperspace-cli paperspace machines list | jq -r '.[] | select(.name|test("Testy")) | .id')

docker run --rm --interactive --tty \
  --env=PAPERSPACE_API_KEY \
  --env=PAPERSPACE_MACHINE_ID \
  polymathrobotics/paperspace-cli paperspace machines waitfor \
    --machineId "$PAPERSPACE_MACHINE_ID" \
    --state "ready"

PAPERSPACE_PUBLIC_IP=$(docker run --rm --tty \
  --env=PAPERSPACE_API_KEY \
  --env=PAPERSPACE_MACHINE_ID \
  polymathrobotics/paperspace-cli paperspace machines list | jq -r '.[] | select(.name|test("Testy")) | .publicIpAddress')

ssh -A "paperspace@${PAPERSPACE_PUBLIC_IP}"
```

# Listing running machines:
```
docker run --rm --interactive --tty \
  --env=PAPERSPACE_API_KEY \
  polymathrobotics/paperspace-cli paperspace machines list
```

# Stopping a machine:
```
docker run --rm --interactive --tty \
  --env=PAPERSPACE_API_KEY \
  --env=PAPERSPACE_MACHINE_ID \
  polymathrobotics/paperspace-cli paperspace machines stop \
    --machineId "$PAPERSPACE_MACHINE_ID"
```

# (Re)starting a machine:
```
docker run --rm --interactive --tty \
  --env=PAPERSPACE_API_KEY \
  --env=PAPERSPACE_MACHINE_ID \
  polymathrobotics/paperspace-cli paperspace machines start \
    --machineId "$PAPERSPACE_MACHINE_ID"
```

# Display machine attributes:
```
docker run --rm --interactive --tty \
  --env=PAPERSPACE_API_KEY \
  --env=PAPERSPACE_MACHINE_ID \
  polymathrobotics/paperspace-cli paperspace machines show \
    --machineId "$PAPERSPACE_MACHINE_ID"
```

# Disabling auto-start on a running machine:
```
docker run --rm --interactive --tty \
  --env=PAPERSPACE_API_KEY \
  --env=PAPERSPACE_MACHINE_ID \
  polymathrobotics/paperspace-cli paperspace machines update \
    --machineId "$PAPERSPACE_MACHINE_ID" \
	--shutdownTimeoutForces false
```  

# Destroying a machine:
```
docker run --rm --interactive --tty \
  --env=PAPERSPACE_API_KEY \
  --env=PAPERSPACE_MACHINE_ID \
  polymathrobotics/paperspace-cli paperspace machines destroy \
    --machineId "$PAPERSPACE_MACHINE_ID"
```
