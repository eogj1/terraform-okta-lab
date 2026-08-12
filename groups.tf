# Directory and group model, defined declaratively.
# These groups are the access-control primitive: app access is granted to
# groups, not individuals, so membership is the only thing that changes.

resource "okta_group" "engineering" {
  name        = "Engineering"
  description = "Engineering department, birthright-assigned by user.department"
}

resource "okta_group" "sales" {
  name        = "Sales"
  description = "Sales department, birthright-assigned by user.department"
}

resource "okta_group" "it" {
  name        = "IT"
  description = "IT department, birthright-assigned by user.department"
}
