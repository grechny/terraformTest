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
  type = list(string)
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Create an Instance Template resource
resource "google_compute_instance_template" "test_instance_template" {
  name         = "test-instance-template"
  machine_type = "e2-micro"  # Replace with desired machine type

  network_interface {
    network = "default"
  }

  # Replace placeholders below with actual values from your CLI example
  boot {
    initialize_params {
      image = "projects/debian-cloud/global/images/debian-11"
      disk_size_gb = 10
    }
  }

  service_account {
    email = "831965780848-compute@developer.gserviceaccount.com"
    scopes = var.scopes
  }
}

# Create a Managed Instance Group resource
resource "google_compute_instance_group_manager" "manual_test" {
  name                = "manual-test"
  base_instance_name  = "manual-test"
  instance_template   = google_compute_instance_template.test_instance_template.self_link
  zone                = var.zone
  target_size         = 1

  metadata = {
    items = {
      enable-vtpm = "true"
      enable-integrity-monitoring = "true"
    }
  }
}
