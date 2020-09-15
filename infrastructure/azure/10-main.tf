terraform {
  required_version = "~> 0.12.29"
}

provider "azurerm" {
  version = "~> 2.25.0"
  features {}
}

resource "random_string" "random_string_log_analytics_workspace_name_suffix" {
  length = 4
  special = false
  upper = false
}