data "github_actions_public_key" "repo_key" {
  repository = local.github_repo.name
}

resource "github_actions_secret" "secret" {
  for_each        = tomap({ for secret in var.secrets : secret.name => secret.value })
  repository      = local.github_repo.name
  secret_name     = each.key
  encrypted_value = base64encode(each.value)
  
  depends_on = [data.github_actions_public_key.repo_key]
}

resource "github_actions_variable" "variable" {
  for_each      = tomap({ for _var in var.vars : _var.name => _var.value })
  repository    = local.github_repo.name
  variable_name = each.key
  value         = each.value
}
