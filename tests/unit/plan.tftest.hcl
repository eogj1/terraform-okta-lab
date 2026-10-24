# Unit tests: offline, mocked Okta provider, no org or API token needed.
# Run with `terraform test -test-directory=tests/unit`.

mock_provider "okta" {}

variables {
  okta_org_name  = "dev-000000"
  okta_api_token = "mock"
}

run "birthright_model" {
  command = apply

  assert {
    condition     = length(okta_group.department) == 3
    error_message = "Expected one group per department."
  }

  assert {
    condition     = okta_group_rule.birthright["engineering"].expression_value == "user.department == \"Engineering\""
    error_message = "Engineering birthright rule expression is wrong."
  }

  assert {
    condition     = okta_group_rule.birthright["it"].name == "it-birthright"
    error_message = "Rule names should be <department-key>-birthright."
  }

  assert {
    condition     = okta_user.lab["sam.seller"].department == "Sales"
    error_message = "User department should be the department display name."
  }

  assert {
    condition     = okta_app_group_assignment.eng_dashboard_access.group_id == okta_group.department["engineering"].id
    error_message = "Dashboard should be assigned to the Engineering group only."
  }
}

run "rejects_unknown_user_department" {
  command = plan

  variables {
    users = {
      "bad.user" = {
        first_name = "Bad"
        last_name  = "User"
        email      = "bad.user@example.com"
        department = "marketing"
      }
    }
  }

  expect_failures = [okta_user.lab]
}
