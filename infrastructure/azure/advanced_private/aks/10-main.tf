terraform {
  required_version = "~> 0.13.3"

  backend "local" {
    path = "./aks-private.tfstate"
  }
}

provider "azurerm" {
  version = "~> 2.27.0"
  features {}
}

data "terraform_remote_state" "networking" {
  backend = "local"

  config = {
    path = "${path.module}/../networking/networking.tfstate"
  }
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
  location    = data.terraform_remote_state.networking.outputs.resource_group.location
  environment = terraform.workspace
}