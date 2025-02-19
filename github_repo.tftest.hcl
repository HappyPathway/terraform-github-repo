# valid_string_concat.tftest.hcl
variables {
  name               = "github-repo-test"
  repo_org          = "HappyPathway"
  force_name        = true
  github_is_private = true
  enforce_prs       = false
  archive_on_destroy = false
  github_org_teams  = []
  admin_teams       = ["test-team"]
  github_repo_description = "Test repository"
  github_repo_topics = ["test", "terraform"]
  create_repo = true
  security_and_analysis = {
    advanced_security = {
      status = "enabled"
    }
    secret_scanning = {
      status = "enabled"
    }
    secret_scanning_push_protection = {
      status = "enabled"
    }
  }
  secrets = [
    {
      name  = "TEST_SECRET"
      value = "secret-value"
    }
  ]
  vars = [
    {
      name  = "TEST_VAR"
      value = "test-value"
    }
  ]
  extra_files = [
    {
      path    = "test.md"
      content = "Test content"
    }
  ]
}

run "repo_tests" {
  command = plan

  assert {
    condition     = github_repository.repo.name == "github-repo-test"
    error_message = "Github Repo name did not match expected"
  }
}

run "create_new_repository" {
  command = plan

  assert {
    condition = module.github_repo[0].name == var.name
    error_message = "Repository name does not match input"
  }

  assert {
    condition = module.github_repo[0].visibility == "private"
    error_message = "Repository visibility should be private"
  }

  assert {
    condition = contains(module.github_repo[0].topics, "test")
    error_message = "Repository topics should include 'test'"
  }

  assert {
    condition = contains(module.github_repo[0].topics, "terraform")
    error_message = "Repository topics should include 'terraform'"
  }

  assert {
    condition = module.github_repo[0].security_and_analysis.advanced_security.status == "enabled"
    error_message = "Advanced security should be enabled"
  }

  assert {
    condition = module.github_repo[0].security_and_analysis.secret_scanning.status == "enabled"
    error_message = "Secret scanning should be enabled"
  }
}

run "verify_data_source" {
  variables {
    create_repo = false
  }

  command = plan

  assert {
    condition = data.github_repository.existing[0].name == var.name
    error_message = "Data source repository name does not match input"
  }
}

run "verify_branch_protection" {
  variables {
    github_default_branch = "main"
    enforce_prs = true
    github_is_private = false
    github_required_approving_review_count = 2
  }

  command = plan

  assert {
    condition = github_branch_protection.main[0].pattern == "main"
    error_message = "Branch protection pattern should be main"
  }

  assert {
    condition = github_branch_protection.main[0].required_pull_request_reviews[0].required_approving_review_count == 2
    error_message = "Should require 2 review approvals"
  }
}

run "verify_repository_files" {
  command = plan

  assert {
    condition = github_repository_file.extra_files["test.md"].file == "test.md"
    error_message = "Extra file should be created"
  }

  assert {
    condition = github_repository_file.extra_files["test.md"].content == "Test content"
    error_message = "Extra file content should match input"
  }
}

run "verify_team_access" {
  command = plan

  assert {
    condition = github_team_repository.admin["test-team"].permission == "admin"
    error_message = "Team should have admin access"
  }
}

run "verify_action_secrets" {
  command = plan

  assert {
    condition = github_actions_secret.secret["TEST_SECRET"].secret_name == "TEST_SECRET"
    error_message = "Action secret should be created"
  }

  assert {
    condition = github_actions_variable.variable["TEST_VAR"].variable_name == "TEST_VAR"
    error_message = "Action variable should be created"
  }
}

run "verify_outputs" {
  command = plan

  assert {
    condition = output.github_repo.name == var.name
    error_message = "Output repository name does not match input"
  }

  assert {
    condition = output.ssh_clone_url != ""
    error_message = "SSH clone URL should not be empty"
  }

  assert {
    condition = output.node_id != ""
    error_message = "Node ID should not be empty"
  }

  assert {
    condition = output.full_name != ""
    error_message = "Full name should not be empty"
  }

  assert {
    condition = output.repo_id != null
    error_message = "Repository ID should not be null"
  }

  assert {
    condition = output.html_url != ""
    error_message = "HTML URL should not be empty"
  }

  assert {
    condition = output.http_clone_url != ""
    error_message = "HTTP clone URL should not be empty"
  }

  assert {
    condition = output.git_clone_url != ""
    error_message = "Git clone URL should not be empty"
  }

  assert {
    condition = output.visibility == "private"
    error_message = "Visibility should be private"
  }

  assert {
    condition = output.default_branch == "main"
    error_message = "Default branch should be 'main'"
  }

  assert {
    condition = length(output.topics) == 2
    error_message = "Should have exactly 2 topics"
  }
}
