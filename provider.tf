provider "google" {
  credentials   = var.api_key
  project       = var.project_id
  region        = var.region
}