output "github_repo" {
  description = "All attributes of the GitHub repository"
  value       = local.github_repo
}

output "ssh_clone_url" {
  description = "URL that can be provided to git clone to clone the repository via SSH"
  value       = local.github_repo.ssh_clone_url
}

output "node_id" {
  description = "Node ID of the repository, used for GraphQL API access"
  value       = local.github_repo.node_id
}

output "full_name" {
  description = "Full name of the repository in org/repo format"
  value       = local.github_repo.full_name
}

output "repo_id" {
  description = "Repository ID"
  value       = local.github_repo.repo_id
}

output "html_url" {
  description = "URL to the repository on GitHub"
  value       = local.github_repo.html_url
}

output "http_clone_url" {
  description = "URL that can be provided to git clone to clone the repository via HTTPS"
  value       = local.github_repo.http_clone_url
}

output "git_clone_url" {
  description = "URL that can be provided to git clone to clone the repository anonymously via the git protocol"
  value       = local.github_repo.git_clone_url
}

output "visibility" {
  description = "Whether the repository is private or public"
  value       = local.github_repo.visibility
}

output "default_branch" {
  description = "Default branch of the repository"
  value       = local.github_repo.default_branch
}

output "topics" {
  description = "List of topics applied to the repository"
  value       = local.github_repo.topics
}

output "template" {
  description = "Template repository this repository was created from"
  value       = local.github_repo.template
}


output "generated_deploy_keys" {
  description = "Generated private keys for deploy keys with create=true"
  value = {
    for k, v in tls_private_key.deploy_key : k => v.private_key_pem
  }
  sensitive = true
}