# pspace

A CLI for using the Paperspace API

This container image repackages releases from https://github.com/Paperspace/cli

## CLI

```bash
% docker run -it --rm --platform linux/amd64 polymathrobotics/pspace
A CLI for using the Paperspace API.

It allows you to authenticate, launch deployments, do logging, and more.

* Deploy an ML app with the `deployment` command
* View a deployed app with the `deployment open` command
* Check the status of a deployment with the `deployment status` command

Read the full documentation at: https://docs.paperspace.com/

Usage
  pspace [command]
  pspace [flags]

Available Commands
  completion  Generate an autocompletion script for the specified shell
  config      Manage your local Paperspace configuration.
  console     Open the Paperspace web console.
  deployment  Effortlessly deploy ML apps to Paperspace.
  docs        Open Paperspace documention in your default browser.
  help        Show help for a pspace command
  init        Create a new Paperspace app
  login       Log in to the CLI.
  logout      Log out of the CLI.
  project     Manage your Paperspace projects.
  secret      Manage your Paperspace secrets
  signup      Sign up for a Paperspace account.
  up          Deploy your app to Paperspace
  upgrade     Upgrade pspace to the latest version.
  version     Show version information

Global Flags
      --api-key   string  A Paperspace public API Key used for authenticating requests
      --api-url   string  A URL for the Paperspace API.
  -h, --help              Show help for a command
  -j, --json              Output JSON
  -l, --log-level string  Enable debug logging

Use "pspace [command] --help" for more information about a command.
```
