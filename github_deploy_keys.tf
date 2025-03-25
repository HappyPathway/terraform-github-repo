// This file implements GitHub Deploy Keys functionality for the repository

resource "github_repository_deploy_key" "deploy_key" {
  for_each   = { for k, v in var.deploy_keys : k => v }
  
  title      = each.value.title
  repository = local.github_repo.name
  key        = each.value.key
  read_only  = each.value.read_only
  
  depends_on = [
    github_repository.repo
  ]
}