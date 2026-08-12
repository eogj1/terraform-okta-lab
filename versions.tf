terraform {
  required_version = ">= 1.5"

  required_providers {
    okta = {
      source = "okta/okta"
      # Check registry.terraform.io/providers/okta/okta for the current
      # major version and bump this if init pulls something newer.
      version = "~> 4.0"
    }
  }
}

provider "okta" {
  org_name  = var.okta_org_name
  base_url  = var.okta_base_url
  api_token = var.okta_api_token
}
