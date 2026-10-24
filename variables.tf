# --- Okta connection --------------------------------------------------------

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

# --- Directory model --------------------------------------------------------

variable "departments" {
  type        = map(string)
  description = "Departments to model. Key is a stable identifier, value is the Okta group name and the user.department value that maps to it."
  default = {
    engineering = "Engineering"
    sales       = "Sales"
    it          = "IT"
  }
}

variable "users" {
  type = map(object({
    first_name = string
    last_name  = string
    email      = string
    department = string
  }))
  description = "Test users keyed by a stable identifier. department must be one of the keys in var.departments. Login is set to email."
  default = {
    "ada.engineer" = {
      first_name = "Ada"
      last_name  = "Engineer"
      email      = "ada.engineer@example.com"
      department = "engineering"
    }
    "sam.seller" = {
      first_name = "Sam"
      last_name  = "Seller"
      email      = "sam.seller@example.com"
      department = "sales"
    }
    "ike.admin" = {
      first_name = "Ike"
      last_name  = "Admin"
      email      = "ike.admin@example.com"
      department = "it"
    }
  }
}

variable "dashboard_department" {
  type        = string
  description = "Key in var.departments whose group is granted the internal dashboard app."
  default     = "engineering"
}
