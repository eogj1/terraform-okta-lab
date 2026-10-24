terraform {
  required_version = ">= 1.5"

  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 4.0"
    }
  }
}
