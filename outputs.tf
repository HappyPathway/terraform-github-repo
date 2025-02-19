output "github_repo" {
  value = local.github_repo
}

output "ssh_clone_url" {
  description = "URL that can be provided to git clone to clone the repository via SSH"
  value       = local.github_repo.ssh_clone_url
}
