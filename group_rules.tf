# Birthright access as code.
#
# Each rule evaluates a user profile attribute and assigns group membership
# automatically. This is the declarative equivalent of a joiner/mover/leaver
# framework: no manual add/remove, membership is derived from the department
# attribute. Change department in the directory and access re-derives on the
# next evaluation. This is the piece to talk through in an interview.

resource "okta_group_rule" "engineering_birthright" {
  name              = "engineering-birthright"
  status            = "ACTIVE"
  group_assignments = [okta_group.engineering.id]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "user.department == \"Engineering\""
}

resource "okta_group_rule" "sales_birthright" {
  name              = "sales-birthright"
  status            = "ACTIVE"
  group_assignments = [okta_group.sales.id]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "user.department == \"Sales\""
}

resource "okta_group_rule" "it_birthright" {
  name              = "it-birthright"
  status            = "ACTIVE"
  group_assignments = [okta_group.it.id]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "user.department == \"IT\""
}
