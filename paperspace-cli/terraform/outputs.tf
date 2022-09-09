output "private_ip_address" {
  value = paperspace_machine.core_machine.private_ip_address
}

output "public_ip_address" {
  value = paperspace_machine.core_machine.public_ip_address
}

output "machine_id" {
  value = paperspace_machine.core_machine.id
}

output "machine_name" {
  value = paperspace_machine.core_machine.name
}

output "dt_created" {
  value = paperspace_machine.core_machine.dt_created
}

output "dt_last_run" {
  value = paperspace_machine.core_machine.dt_last_run
}

output "os" {
  value = paperspace_machine.core_machine.os
}

output "ram" {
  value = paperspace_machine.core_machine.ram
}

output "cpus" {
  value = paperspace_machine.core_machine.cpus
}

output "gpus" {
  value = paperspace_machine.core_machine.gpu
}

output "storage_total" {
  value = paperspace_machine.core_machine.storage_total
}

output "storage_used" {
  value = paperspace_machine.core_machine.storage_used
}

output "usage_rate" {
  value = paperspace_machine.core_machine.usage_rate
}

output "shutdown_timeout_in_hours" {
  value = paperspace_machine.core_machine.shutdown_timeout_in_hours
}
