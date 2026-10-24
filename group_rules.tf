# Birthright access as code.
#
# Each rule evaluates a user profile attribute and assigns group membership
# automatically. This is the declarative equivalent of a joiner/mover/leaver
# framework: no manual add/remove, membership is derived from the department
# attribute. Change department in the directory and access re-derives on the
# next evaluation.

resource "okta_group_rule" "birthright" {
  for_each = var.departments

  name              = "${each.key}-birthright"
  status            = "ACTIVE"
  group_assignments = [okta_group.department[each.key].id]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "user.department == \"${each.value}\""
}
