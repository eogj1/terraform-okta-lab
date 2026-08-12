# Test users. The department attribute is the single source of truth that
# drives group membership via the group rules in group_rules.tf. This mirrors
# an HRIS attribute (Rippling, UKG Pro) feeding a joiner/mover/leaver flow:
# change department, and access follows automatically.

resource "okta_user" "eng_user" {
  first_name = "Ada"
  last_name  = "Engineer"
  login      = "ada.engineer@example.com"
  email      = "ada.engineer@example.com"
  department = "Engineering"
}

resource "okta_user" "sales_user" {
  first_name = "Sam"
  last_name  = "Seller"
  login      = "sam.seller@example.com"
  email      = "sam.seller@example.com"
  department = "Sales"
}

resource "okta_user" "it_user" {
  first_name = "Ike"
  last_name  = "Admin"
  login      = "ike.admin@example.com"
  email      = "ike.admin@example.com"
  department = "IT"
}
