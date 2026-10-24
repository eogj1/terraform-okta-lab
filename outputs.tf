output "group_ids" {
  description = "IDs of the department groups, keyed by department"
  value       = { for k, g in okta_group.department : k => g.id }
}

output "birthright_rule_ids" {
  description = "IDs of the birthright group rules, keyed by department"
  value       = { for k, r in okta_group_rule.birthright : k => r.id }
}

output "user_ids" {
  description = "IDs of the test users, keyed by user"
  value       = { for k, u in okta_user.lab : k => u.id }
}

output "dashboard_app_id" {
  description = "Client ID of the internal dashboard OIDC app"
  value       = okta_app_oauth.internal_dashboard.client_id
}
