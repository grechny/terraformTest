# Create an Instance Template resource
resource "google_compute_region_instance_template" "generic_instance_template" {
  name                  = "${var.name}-instanse-template"
  machine_type          = var.machineType
  tags                  = [ var.name ]

  network_interface {
    network = "default"
  }

  disk {
    source_image        = var.image
    auto_delete         = false
    boot                = true
  }

  disk {
    source_image        = var.image
    device_name         = "${var.name}-disk001"
    auto_delete         = false
    boot                = false
    disk_type           = "pd-standard"
    disk_size_gb        = 10
  }

  service_account {
    email               = "831965780848-compute@developer.gserviceaccount.com"
    scopes              = var.scopes
  }

  metadata = {
    user-data = file("./module/generic/init-script.sh")
  }
}

# Create a Managed Instance Group resource
resource "google_compute_region_instance_group_manager" "generic_instance_group" {
  name                  = "${var.name}-instanse-group"
  base_instance_name    = var.name

  version {
    instance_template  = google_compute_region_instance_template.generic_instance_template.self_link
  }

  update_policy {
    type                           = "PROACTIVE"
    instance_redistribution_type   = "NONE"
    minimal_action                 = "REFRESH"
    most_disruptive_allowed_action = "REPLACE"
    replacement_method             = "RECREATE"
    max_unavailable_fixed          = 3
  }

  stateful_disk {
    device_name = "${var.name}-disk001"
    delete_rule = "NEVER"
  }

  stateful_internal_ip {
    interface_name = "nic0"
    delete_rule = "NEVER"
  }
}
