# https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/team
# data "github_team" "github_codeowners_team" {
#   slug = var.github_codeowners_team
# }

# not creating main branch because its created by default when repo is created
resource "github_branch" "branch" {
  count      = var.github_default_branch == "main" ? 0 : 1
  repository = local.github_repo.name
  branch     = var.github_default_branch
  depends_on = [
    github_repository.repo
  ]
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