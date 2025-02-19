locals {
  repo_exists = var.create_repo ? github_repository.repo[0] : data.github_repository.existing[0]
}

# data "github_actions_public_key" "repo_key" {
#   repository = local.github_repo.name
#   count     = local.repo_exists != null ? 1 : 0
# }

resource "github_actions_secret" "secret" {
  for_each        = tomap({ for secret in var.secrets : secret.name => secret.value })
  repository      = local.github_repo.name
  secret_name     = each.key
  encrypted_value = base64encode(each.value)
  depends_on      = [local.repo_exists]
}

resource "github_actions_variable" "variable" {
  for_each      = tomap({ for _var in var.vars : _var.name => _var.value })
  repository    = local.github_repo.name
  variable_name = each.key
  value         = each.value
  depends_on    = [local.repo_exists]
}
