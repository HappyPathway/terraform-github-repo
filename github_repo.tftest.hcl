# valid_string_concat.tftest.hcl
variables {
  force_name         = true
  github_is_private  = true
  repo_org           = "HappyPathway"
  name               = "github-repo-test"
  enforce_prs        = false
  archive_on_destroy = false
}

run "repo_tests" {

  command = plan

  assert {
    condition     = github_repository.repo.name == "github-repo-test"
    error_message = "Github Repo name did not match expected"
  }
}
