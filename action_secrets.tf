resource "github_actions_secret" "secret" {
  for_each        = tomap({ for secret in var.secrets : secret.name => secret.value })
  secret_name     = each.key
  plaintext_value = each.value
  repository      = github_repository.repo.name
}

resource "github_actions_variable" "variable" {
  for_each      = tomap({ for _var in var.vars : _var.name => _var.value })
  repository    = github_repository.repo.name
  variable_name = each.key
  value         = each.value
}
