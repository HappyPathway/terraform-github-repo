# Add a collaborator to a repository
resource "github_repository_collaborator" "collaborators" {
  for_each   = tomap(var.collaborators)
  repository = local.github_repo.name
  username   = each.key
  permission = each.value
}
