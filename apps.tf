# Application integration plus least-privilege access assignment.
#
# The app is assigned to a group, not to individuals. Combined with the
# birthright rules, this means a hire in the dashboard department gets access
# to this app automatically and loses it automatically if their department
# changes. Standards-based provisioning (OIDC) defined as code.

resource "okta_app_oauth" "internal_dashboard" {
  label          = "Internal Engineering Dashboard"
  type           = "web"
  grant_types    = ["authorization_code"]
  redirect_uris  = ["https://example.com/authorization-code/callback"]
  response_types = ["code"]
}

# Least privilege: only one department's group gets this app.
resource "okta_app_group_assignment" "eng_dashboard_access" {
  app_id   = okta_app_oauth.internal_dashboard.id
  group_id = okta_group.department[var.dashboard_department].id

  lifecycle {
    precondition {
      condition     = contains(keys(var.departments), var.dashboard_department)
      error_message = "dashboard_department must be a key in var.departments."
    }
  }
}
