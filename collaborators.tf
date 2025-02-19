locals {
  # Permission mapping for collaborator roles
  permission_map = {
    "pull"     = "read"
    "triage"   = "triage"
    "push"     = "write"
    "maintain" = "maintain"
    "admin"    = "admin"
  }
}

data "github_user" "collaborators" {
  for_each = var.collaborators
  username = each.key
}

# Add a collaborator to a repository
resource "github_repository_collaborator" "collaborators" {
  for_each   = tomap(var.collaborators)
  repository = local.github_repo.name
  username   = each.key
  permission = local.permission_map[each.value]

  depends_on = [
    data.github_user.collaborators
  ]
}
