
# https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/team
# data "github_team" "github_codeowners_team" {
#   slug = var.github_codeowners_team
# }

# not creating main branch because its created by default when repo is created
resource "github_branch" "branch" {
  count      = var.github_default_branch == "main" ? 0 : 1
  repository = github_repository.repo.name
  branch     = var.github_default_branch
}


# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default
resource "github_branch_default" "default_main_branch" {
  count      = var.github_default_branch == "main" ? 0 : 1
  repository = github_repository.repo.name
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
  count          = var.enforce_prs && !var.github_is_private ? 1 : 0
  enforce_admins = var.github_enforce_admins_branch_protection
  pattern        = var.github_default_branch
  # push_restrictions = var.github_push_restrictions
  repository_id = github_repository.repo.node_id
  required_pull_request_reviews {
    dismiss_stale_reviews           = var.github_dismiss_stale_reviews
    require_code_owner_reviews      = var.github_require_code_owner_reviews
    required_approving_review_count = var.github_required_approving_review_count
    pull_request_bypassers          = local.pull_request_bypassers
  }
  lifecycle {
    ignore_changes = [
      required_status_checks[0].contexts
    ]
  }

  dynamic "required_status_checks" {
    for_each = var.required_status_checks == null ? [] : ["*"]
    content {
      contexts = required_status_checks.value.contexts
      strict   = required_status_checks.value.strict
    }
  }

  depends_on = [
    # first let the automation create the codeowners and backend file then only create branch protection rule
    # if branch protection rule is created first, codeowners will fail
    github_repository_file.codeowners,
    github_repository_file.extra_files
  ]
}
