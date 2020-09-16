terraform {
  required_version = "~> 0.12.29"
}

provider "azurerm" {
  version = "~> 2.25.0"
  features {}
}


resource "random_string" "prefix" {
  length = 4
  number = false
  special = false
  upper = false
}

resource "random_string" "suffix" {
  length = 4
  special = false
  upper = false
}

locals {
  prefix      = var.prefix != "" ? var.prefix : random_string.prefix.result
  suffix      = var.suffix != "" ? var.suffix : random_string.suffix.result
  location    = var.location
  environment = terraform.workspace
}