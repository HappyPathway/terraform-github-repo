# Add a collaborator to a repository
resource "github_repository_collaborator" "collaborators" {
  for_each   = tomap(var.collaborators)
  repository = github_repository.repo.name
  username   = each.key
  permission = each.value
  depends_on = [
    github_repository.repo
  ]
}
