variable "okta_org_name" {
  type        = string
  description = "Okta org subdomain. For a developer org this is the part before .okta.com, e.g. dev-123456"
}

variable "okta_base_url" {
  type        = string
  description = "Okta base domain. Developer orgs use okta.com; some orgs use oktapreview.com"
  default     = "okta.com"
}

variable "okta_api_token" {
  type        = string
  description = "API token created under Security > API > Tokens in the Okta admin console"
  sensitive   = true
}
