# Okta Identity-as-Code Lab

A small Terraform project that manages an Okta org declaratively: directory
groups, users, birthright group rules, an OIDC application, and least-privilege
group-based app access. Built to practice Terraform and Okta hands-on and to
express a joiner/mover/leaver birthright-access model as configuration-as-code.

## What it provisions

- Three department groups (Engineering, Sales, IT)
- Three test users, each with a `department` attribute
- Three birthright group rules that assign group membership from the
  `department` attribute automatically
- One OIDC application
- A least-privilege assignment granting the app only to the Engineering group

The core idea: access is derived from a directory attribute, not assigned by
hand. Change a user's department and their access re-derives on the next rule
evaluation. That is a joiner/mover/leaver flow expressed as code.

## Prerequisites

1. A free Okta Developer account (developer.okta.com). The developer edition
   is free and supports the API and Terraform provider.
2. An API token: Okta admin console > Security > API > Tokens > Create Token.
3. Terraform >= 1.5 installed locally.

## Run it

```
cp terraform.tfvars.example terraform.tfvars   # then edit in your values
terraform init      # downloads the Okta provider, writes the lock file
terraform plan      # review what will be created, nothing is applied yet
terraform apply      # creates the resources after you confirm
terraform destroy    # tears everything back down when you are done
```

The plan/apply/destroy cycle is the whole point: desired state is defined in
these files, Terraform reconciles the org to match, and state tracks what
exists so drift can be detected and corrected.

## Design notes

- App access is granted to groups, never to individual users, so membership is
  the only lever. This is least privilege by construction.
- The `department` attribute is the single source of truth. In production this
  attribute would sync from an HRIS (Rippling, UKG Pro), which is how a real
  birthright flow is fed.
- State and secrets are kept out of Git. `terraform.tfvars` (your token) and
  `*.tfstate` are gitignored. The provider lock file is committed on purpose,
  so runs are reproducible.
- The MFA policy in `policies.tf` is left commented as a stretch goal so the
  first apply succeeds without needing factors configured first.

## Next steps (maturity, if you want to extend)

- Enable MFA factors and uncomment the policy in `policies.tf`.
- Move state to a remote backend (for example an S3 bucket with locking)
  instead of local state.
- Add a SAML app alongside the OIDC one to show both provisioning standards.

## How this maps to interview questions

- Config-as-code: this is declarative desired-state with drift detection and
  version control, the same mindset as MDM configuration profiles, applied to
  identity infrastructure.
- Birthright / joiner-mover-leaver: the group rules are the showcase.
- Least privilege: group-based app assignment, not user-based.
- Standards-based provisioning: OIDC app defined as code.
- Honest framing: this is a personal lab built to go deeper on Terraform and
  Okta. It is real hands-on work, not production experience at an employer, and
  should be described that way.
