terraform {
  required_version = "~> 0.12.29"
}

provider "azurerm" {
  version = "~> 2.25.0"
  features {}
}

resource "random_string" "suffix" {
  length = 4
  special = false
  upper = false
}

locals {
  environment = terraform.workspace
  suffix      = random_string.suffix.result
}