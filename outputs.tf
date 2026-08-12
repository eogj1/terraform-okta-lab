output "engineering_group_id" {
  description = "ID of the Engineering group"
  value       = okta_group.engineering.id
}

output "birthright_rule_ids" {
  description = "IDs of the birthright group rules"
  value = {
    engineering = okta_group_rule.engineering_birthright.id
    sales       = okta_group_rule.sales_birthright.id
    it          = okta_group_rule.it_birthright.id
  }
}

output "dashboard_app_id" {
  description = "Client ID of the internal dashboard OIDC app"
  value       = okta_app_oauth.internal_dashboard.client_id
}
