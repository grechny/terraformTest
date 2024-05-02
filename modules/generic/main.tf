# Create an Instance Template resource
resource "google_compute_region_instance_template" "generic_instance_template" {
  name                  = "${var.name}-instanse-template"
  machine_type          = var.machineType

  network_interface {
    network = "default"
  }

  disk {
    source_image        = var.image
    auto_delete         = false
    boot                = true
  }

  service_account {
    email               = "831965780848-compute@developer.gserviceaccount.com"
    scopes              = var.scopes
  }
}

# Create a Managed Instance Group resource
resource "google_compute_instance_group_manager" "generic_instance_group" {
  name                  = "${var.name}-instanse-group"
  base_instance_name    = var.name
  zone                  = var.zone
  target_size           = 0
  version {
    instance_template   = google_compute_region_instance_template.generic_instance_template.self_link
  }

  stateful_disk {
    device_name = "${var.name}-disk"
    delete_rule = "ON_PERMANENT_INSTANCE_DELETION"
  }

  stateful_internal_ip {
    interface_name = "nic0"
    delete_rule = "ON_PERMANENT_INSTANCE_DELETION"
  }

  stateful_external_ip {
    interface_name = "nic0"
    delete_rule = "ON_PERMANENT_INSTANCE_DELETION"
  }
}
