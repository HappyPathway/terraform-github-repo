resource "github_actions_secret" "secret" {
  for_each        = tomap({ for secret in var.secrets : secret.name => secret.value })
  secret_name     = each.key
  plaintext_value = each.value
  repository      = local.github_repo.name
}

resource "github_actions_variable" "variable" {
  for_each      = tomap({ for _var in var.vars : _var.name => _var.value })
  repository    = local.github_repo.name
  variable_name = each.key
  value         = each.value
}
