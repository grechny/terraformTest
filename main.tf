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
