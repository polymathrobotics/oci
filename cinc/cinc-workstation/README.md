## cinc-workstation

Cinc Workstation contains all the same tools as Chef Workstation™, some of them had to be modified for compliance:

- mixlib-install serves Cinc Products
- Chef Infra™ –> Cinc Client
  - chef –> cinc
  - chef-analyze –> cinc-analyze
  - chef-apply –> cinc-apply
  - chef-shell –> cinc-shell
  - chef-solo –> cinc-zero
  - chef-zero –> cinc-zero
- Chef Inspec™ –> Cinc Auditor
- Chef Workstation App removed
  - This has been removed from our builds due to the extensive word mark replacements which are required and needed maintained.
- Habitat -> Biome

## Configuration

Cinc uses the `~/.cinc-workstation` folder for it’s configuration on Unix-like systems and `%USERPROFILE%\.cinc-workstation` on Windows.

Users migrating from Chef will probably want to retain most of their configuration. All Cinc configurations are compatible with their Chef counterparts so you can simply use a symlink or copy the contents as-is.

## Usage

Cinc Workstation’s tools are fully compatible with their Chef Workstation counterparts. Many are in fact not modified at all. We include wrappers for Chef Workstation binaries we’ve renamed to the Cinc binaries. This should facilitate compatibility with your existing automation.

All [upstream documentation](https://docs.chef.io/) remains valid, and so are the [classes provided by Chef Software Inc.](https://learn.chef.io/).
