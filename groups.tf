# Directory and group model, defined declaratively.
# These groups are the access-control primitive: app access is granted to
# groups, not individuals, so membership is the only thing that changes.

resource "okta_group" "department" {
  for_each = var.departments

  name        = each.value
  description = "${each.value} department, birthright-assigned by user.department"
}
