# https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/team
# data "github_team" "github_codeowners_team" {
#   slug = var.github_codeowners_team
# }

# Create non-main default branch if specified
resource "github_branch" "branch" {
  repository = local.github_repo.name
  branch     = var.github_default_branch

  # Only create if not "main" and repository exists
  lifecycle {
    precondition {
      condition     = var.github_default_branch != "main"
      error_message = "Default branch is 'main', skipping branch creation as it's created by default"
    }
  }

  depends_on = [
    github_repository.repo
  ]
}

# Set the default branch
resource "github_branch_default" "default_main_branch" {
  repository = local.github_repo.name
  branch     = var.github_default_branch

  # Only set if not "main"
  lifecycle {
    precondition {
      condition     = var.github_default_branch != "main"
      error_message = "Default branch is already 'main', no need to set default"
    }
  }

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