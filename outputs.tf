output "github_repo" {
  value = github_repository.repo
}

output "ssh_clone_url" {
  description = "URL that can be provided to git clone to clone the repository via SSH"
  value       = github_repository.repo.ssh_clone_url
}
