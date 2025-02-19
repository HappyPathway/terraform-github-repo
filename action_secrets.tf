resource "github_actions_secret" "secret" {
  for_each        = tomap({ for secret in var.secrets : secret.name => secret.value })
  repository      = local.github_repo.name
  secret_name     = each.key
  plaintext_value = each.value
  depends_on      = [local.github_repo]
}

resource "github_actions_variable" "variable" {
  for_each      = tomap({ for _var in var.vars : _var.name => _var.value })
  repository    = local.github_repo.name
  variable_name = each.key
  value         = each.value
  depends_on    = [local.github_repo]
}
