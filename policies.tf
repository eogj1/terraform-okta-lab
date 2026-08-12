# STRETCH GOAL, optional. Left commented so your first `terraform apply`
# succeeds cleanly. Uncomment once the core resources apply and you want the
# MFA talking point.
#
# NOTE: policy resource names and schemas differ across Okta provider major
# versions and require MFA factors to be enabled in the org first
# (Security > Multifactor). Check the provider docs for your version before
# uncommenting. This is deliberately the last thing you add, so the rest of
# the build is not blocked by factor configuration.
#
# resource "okta_policy_mfa" "require_mfa" {
#   name        = "Require MFA"
#   status      = "ACTIVE"
#   description = "Baseline MFA policy"
#
#   okta_otp = {
#     enroll = "REQUIRED"
#   }
#
#   groups_included = [okta_group.engineering.id]
# }
