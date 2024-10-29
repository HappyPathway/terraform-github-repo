# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository
data "github_organization_teams" "root_teams" {
  count           = var.github_org_teams == null ? 1 : 0
  root_teams_only = false
}

locals {
  github_org_teams = var.github_org_teams == null ? data.github_organization_teams.root_teams[0].teams : var.github_org_teams
  github_teams     = { for obj in local.github_org_teams : "${obj.slug}" => obj.id }
}

# data "github_team" "nit_admin" {
#   slug = "nit"
# }

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository
resource "github_team_repository" "admin" {
  for_each   = toset(var.admin_teams)
  team_id    = lookup(local.github_teams, each.value)
  repository = github_repository.repo.name
  permission = "admin"
  lifecycle {
    ignore_changes = [
      team_id
    ]
  }
  depends_on = [
    github_repository.repo
  ]
}
