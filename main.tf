module "main" {
  source        = "./modules/generic"

  name          = "test-main"
  machineType  = "e2-micro"
}

module "slave" {
  source        = "./modules/generic"

  name          = "test-slave"
  machineType  = "e2-standard"
}
