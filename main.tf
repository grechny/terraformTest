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

module "main" {
  source        = "./modules/generic"

  name          = "test-main"
  machineType   = "e2-micro"

  project_id    = var.project_id
  region        = var.region
  zone          = var.zone
  scopes        = var.scopes
  api_key       = api_key
}
