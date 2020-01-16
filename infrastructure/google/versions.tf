terraform {
  version = 0.12.19
}

provider "google" {
  region      = var.REGION
  version     = 3.4.0
}