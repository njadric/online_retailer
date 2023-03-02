variable "ACCESS_KEY" {}
variable "SECRET_KEY" {}

variable "REGION" {
  default = "eu-west-1"
}

variable "ENVIRONMENT" {
  default = "${terraform.workspace}"
}
