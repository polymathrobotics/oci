/*
Valid entries for billingType:

  - monthly
  - hourly
*/
variable "billing_type" {
  description = "Billing type"
  default = "hourly"
}

/*
Valid entries for machineType:

  - C1, C2, C3, C4, C5, C6, C7, C8, C9, C10
  - Air
  - Standard
  - Pro
  - Advanced
  - GPU+
  - P4000, P5000, P6000, V100

Note:
Windows os templates cannot be used to create CPU-only machine types 'C1' - 'C10'.
Ubuntu os templates cannot be used to create GRID GPU machine types: 'Air', 'Standard', 'Pro', or 'Advanced'.

To list machine types:
  docker run --rm \
    --env=PAPERSPACE_API_KEY \
    polymathrobotics/paperspace-cli paperspace jobs machineTypes | less
*/
variable "machine_type" {
  description = "Machine type"
  default = "C1"
}

variable "name" {
  description = "A memborable name for this machine"
  default = "default"
}

/*
Valid entries for region:

  - East Coast (NY2)
  - Europe (AMS1)
  - West Coast (CA1)
*/
variable "region" {
  description = "Name of the region"
  default = "East Coast (NY2)"
}

variable "size" {
  description = "Storage size for the machine in GB"
  default = 50
}

variable "team_id" {
  description = "Paperspace team id"
}

variable "template_id" {
  description = "Template id of the template to use for creating this machine"
  default     = "tkni3aa4" # Ubuntu 20.04 Server
}

variable "username" {
  description = "The current user's username"
  default     = "default"
}
