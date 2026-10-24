# Integration tests: apply against a real Okta org, assert, then destroy.
# Not run in CI. Needs okta_org_name and okta_api_token, e.g. via
# TF_VAR_okta_org_name / TF_VAR_okta_api_token, then:
#   terraform test -test-directory=tests/integration
#
# Uses tftest-prefixed names so it can run in the same org as the lab
# without colliding with its groups, rules, or users.

variables {
  departments = {
    tftest-engineering = "tftest Engineering"
    tftest-sales       = "tftest Sales"
  }

  users = {
    "tftest.ada" = {
      first_name = "Ada"
      last_name  = "Tftest"
      email      = "tftest.ada@example.com"
      department = "tftest-engineering"
    }
  }

  dashboard_department = "tftest-engineering"
}

run "apply_birthright_model" {
  command = apply

  assert {
    condition     = length(output.group_ids) == 2 && alltrue([for id in values(output.group_ids) : id != ""])
    error_message = "Expected a created group per department."
  }

  assert {
    condition     = okta_group_rule.birthright["tftest-engineering"].status == "ACTIVE"
    error_message = "Birthright rule should be active."
  }

  assert {
    condition     = okta_user.lab["tftest.ada"].department == "tftest Engineering"
    error_message = "User department attribute should match the department display name."
  }

  assert {
    condition     = okta_app_group_assignment.eng_dashboard_access.group_id == output.group_ids["tftest-engineering"]
    error_message = "Dashboard should be assigned only to the dashboard department group."
  }

  assert {
    condition     = output.dashboard_app_id != ""
    error_message = "OIDC app should have a client ID."
  }
}
