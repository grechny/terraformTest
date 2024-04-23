# Terraform provider for Google Cloud Platform (GCP)
variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "scopes" {
  type = set(string)
}

variable "api_key" {
  type = string
}

provider "google" {
  credentials = var.api_key
  project = var.project_id
  region  = var.region
}

# Create an Instance Template resource
resource "google_compute_region_instance_template" "test_instance_template" {
  name         = "test-instance-template"
  machine_type = "e2-micro"  # Replace with desired machine type

  network_interface {
    network = "default"
  }

  disk {
    source_image      = "projects/cos-cloud/global/images/cos-109-17800-147-60"
    auto_delete       = true
    boot              = true
  }

  service_account {
    email = "831965780848-compute@developer.gserviceaccount.com"
    scopes = var.scopes
  }
}

# Create a Managed Instance Group resource
resource "google_compute_instance_group_manager" "terraform_test" {
  name                = "terraform-test"
  base_instance_name  = "terraform-test"
  zone                = var.zone
  target_size         = 0
  version {
    instance_template   = google_compute_region_instance_template.test_instance_template.self_link
  }

  stateful_disk {
    device_name = "terraform-test-disk"
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
