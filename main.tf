module "main" {
  source        = "./modules/generic"

  name          = "test-main"
  machineType   = "e2-micro"

  project_id    = var.project_id
  region        = var.region
  zone          = var.zone
  scopes        = var.scopes
  api_key       = var.api_key
}

module "slave" {
  source        = "./modules/generic"

  name          = "test-slave"
  machineType   = "e2-standard-2"

  project_id    = var.project_id
  region        = var.region
  zone          = var.zone
  scopes        = var.scopes
  api_key       = var.api_key
}