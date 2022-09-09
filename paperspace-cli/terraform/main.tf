resource "paperspace_machine" "core_machine" {
  region                    = var.region
  name                      = var.name
  machine_type              = var.machine_type
  size                      = var.size
  billing_type              = var.billing_type
  assign_public_ip          = true // optional, remove if you don't want a public ip assigned
  template_id               = var.template_id
  team_id                   = var.team_id
  shutdown_timeout_in_hours = 24
  # live_forever = true # enable this to make the machine have no shutdown timeout
}
