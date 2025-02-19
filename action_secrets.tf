locals {
  repo_exists = var.create_repo ? github_repository.repo[0] : data.github_repository.existing[0]
}

resource "github_actions_secret" "secret" {
  for_each        = tomap({ for secret in var.secrets : secret.name => secret.value })
  repository      = local.repo_exists.name
  secret_name     = each.key
  plaintext_value = each.value
  depends_on      = [local.repo_exists]
}

resource "github_actions_variable" "variable" {
  for_each      = tomap({ for _var in var.vars : _var.name => _var.value })
  repository    = local.repo_exists.name
  variable_name = each.key
  value         = each.value
  depends_on    = [local.repo_exists]
}
