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

variable "name" {
  type = string
}

variable "machineType" {
  type = string
}

variable "image" {
  type = string
  default = "projects/cos-cloud/global/images/cos-109-17800-147-60"
}
