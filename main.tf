variable "name" {
  type = string
}

variable "machineType" {
  type = string
}

module "main" {
  source        = "./modules/generic"

  name          = "test-main"
  machineType   = "e2-micro"
}
