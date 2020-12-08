terraform {
  required_version = "~> 0.13.3"
}

provider "azurerm" {
  version = "~> 2.39.0"
  features {}
}

resource "random_string" "suffix" {
  length = 4
  special = false
  upper = false
}

locals {
  environment = terraform.workspace
  prefix      = var.prefix
  suffix      = var.suffix != "" ? var.suffix : random_string.suffix.result
}