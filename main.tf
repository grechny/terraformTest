# Configure Terraform provider for Google Cloud Platform (GCP)
provider "google" {
  # Replace with your actual GCP project ID
  project = var.project_id
  # Replace with the region where you want to create the instance group (e.g., "europe-west1")
  region  = var.region
}

# Define variables used in the configuration (replace placeholders with your values)
variable "project_id" {
  type = string
  description = "The ID of your GCP project"
}

variable "region" {
  type = string
  description = "The region where you want to create the instance group"
}

variable "scopes" {
  type = list(string)
  description = "A list of comma-separated strings representing the scopes required by your instances (replace with actual scope URLs)"
}

# Create an Instance Template resource
resource "google_compute_instance_template" "test_instance_template" {
  # Name for the instance template
  name         = "test-instance-template"
  # Machine type for the instances (e.g., "e2-micro")
  machine_type = "e2-micro"

  network_interface {
    # Network where the instances will reside (default network is assumed here)
    network = "default"
    # Network tier for the instances (PREMIUM for higher bandwidth)
    tier    = "PREMIUM"
  }

  # ... Replace placeholders below with actual values based on your gcloud CLI command ...

  # Replace with the desired boot disk image URL
  boot_disk {
    initialize_params {
      image = "projects/cos-cloud/global/images/cos-109-17800-147-60"
    }
  }

  # Replace with the desired disk size in GB (e.g., 10)
  disks {
    initialize_params {
      disk_size_gb = 10
    }
  }

  # Replace with a comma-separated list of service accounts with required permissions
  service_account = "831965780848-compute@developer.gserviceaccount.com"

  # Replace with a comma-separated list of required scopes (replace placeholders with actual scope URLs)
  scopes = var.scopes

  # ... End of placeholder replacements ...

  # Shielded VM configuration options (replace with desired settings)
  shielded_vtpm = true
  shielded_integrity_monitoring = true
  # Set to 'any' to allow instances to be created on any available zone within the region
  reservation_affinity = "any"
}

# Create a Managed Instance Group resource
resource "google_compute_instance_group_managed" "manual_test" {
  # Name for the managed instance group
  name               = "manual-test"
  # Base name for the instances in the group (used for auto-generated names)
  base_instance_name  = "manual-test"
  # Reference to the instance template created above
  instance_template   = google_compute_instance_template.test_instance_template.self_link
  # Zone where the instances will be created (replace with a specific zone within the region)
  zone                = var.zone
  # Target number of instances in the group (currently set to 1)
  target_size         = 1
}
