# State migrations from the original one-resource-per-department layout to
# for_each. Lets existing deployments upgrade without destroy/recreate.
# Safe to delete once every workspace has applied this version.

moved {
  from = okta_group.engineering
  to   = okta_group.department["engineering"]
}

moved {
  from = okta_group.sales
  to   = okta_group.department["sales"]
}

moved {
  from = okta_group.it
  to   = okta_group.department["it"]
}

moved {
  from = okta_group_rule.engineering_birthright
  to   = okta_group_rule.birthright["engineering"]
}

moved {
  from = okta_group_rule.sales_birthright
  to   = okta_group_rule.birthright["sales"]
}

moved {
  from = okta_group_rule.it_birthright
  to   = okta_group_rule.birthright["it"]
}

moved {
  from = okta_user.eng_user
  to   = okta_user.lab["ada.engineer"]
}

moved {
  from = okta_user.sales_user
  to   = okta_user.lab["sam.seller"]
}

moved {
  from = okta_user.it_user
  to   = okta_user.lab["ike.admin"]
}
