module "webserver_group" {
  source        = "./modules/generic"

  name          = "test-main"
  machine_type  = "e2-micro"
}

module "database_group" {
  source        = "./modules/generic"

  name          = "test-slave"
  machine_type  = "e2-standard"
}
