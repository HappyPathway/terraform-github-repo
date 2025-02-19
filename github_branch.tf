# https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/team
# data "github_team" "github_codeowners_team" {
#   slug = var.github_codeowners_team
# }

# not creating main branch because its created by default when repo is created
resource "github_branch" "branch" {
  count      = var.github_default_branch == "main" ? 0 : 1
  repository = local.github_repo.name
  branch     = var.github_default_branch
}


# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default
resource "github_branch_default" "default_main_branch" {
  count      = var.github_default_branch == "main" ? 0 : 1
  repository = local.github_repo.name
  branch     = var.github_default_branch
  depends_on = [
    github_branch.branch
  ]
}


data "github_user" "pull_request_bypassers" {
  for_each = toset(var.pull_request_bypassers)
  username = each.value
}

locals {
  pull_request_bypassers = [for user in data.github_user.pull_request_bypassers : user.node_id]
}

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection
resource "github_branch_protection" "main" {
  count = (var.enforce_prs && !var.github_is_private) || var.github_is_private ? 1 : 0

  repository_id = local.github_repo.node_id
  pattern       = var.github_default_branch
  
  # Basic protection settings
  enforce_admins                  = var.github_enforce_admins_branch_protection
  allows_deletions               = false
  allows_force_pushes            = false
  require_signed_commits         = true
  required_linear_history        = true
  require_conversation_resolution = true

  required_status_checks {
    strict = try(var.required_status_checks.strict, false)
    contexts = try(var.required_status_checks.contexts, [])
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = var.github_dismiss_stale_reviews
    restrict_dismissals            = true
    pull_request_bypassers        = var.pull_request_bypassers
    require_code_owner_reviews      = var.github_require_code_owner_reviews
    required_approving_review_count = var.github_required_approving_review_count
  }

  restrict_pushes {
    push_allowances = var.github_push_restrictions
  }

  lifecycle {
    ignore_changes = [
      required_status_checks[0].contexts
    ]
  }
}
