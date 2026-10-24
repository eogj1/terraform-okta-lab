# Test users. The department attribute is the single source of truth that
# drives group membership via the group rules in group_rules.tf. This mirrors
# an HRIS attribute (Rippling, UKG Pro) feeding a joiner/mover/leaver flow:
# change department, and access follows automatically.

resource "okta_user" "lab" {
  for_each = var.users

  first_name = each.value.first_name
  last_name  = each.value.last_name
  login      = each.value.email
  email      = each.value.email
  department = var.departments[each.value.department]

  lifecycle {
    precondition {
      condition     = contains(keys(var.departments), each.value.department)
      error_message = "User ${each.key} has department \"${each.value.department}\", which is not a key in var.departments."
    }
  }
}
