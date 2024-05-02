module "main" {
  source        = "./modules/generic/main.tf"

  name          = "test-main"
  machineType   = "e2-micro"
}
