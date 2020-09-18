terraform {
  required_version = "~> 0.13.3"
}

provider "azurerm" {
  version = "~> 2.27.0"
  features {}
}


resource "random_string" "prefix" {
  length = 4
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