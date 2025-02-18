# Terraform GitHub Repository Module

A comprehensive Terraform module for managing GitHub repositories with advanced features like branch protection, file management, and team access control.

## Features

- Complete GitHub repository management
- Branch protection rules
- File content management
- Team access configuration
- Action secrets management
- Repository collaborator management
- Automated README generation
- Issue management

## Usage

```hcl
module "repository" {
  source = "HappyPathway/repo/github"

  name                     = "my-repository"
  repo_org                = "MyOrganization"
  force_name              = true
  github_repo_description = "Repository description"
  github_repo_topics      = ["terraform", "automation"]
  github_is_private       = false
  github_has_issues       = true
  github_has_projects     = true
  github_has_wiki         = true
  vulnerability_alerts    = true
  gitignore_template      = "Node"

  # Managed file content
  managed_extra_files = {
    "README.md" = {
      content   = file("${path.module}/templates/readme.md")
      overwrite = true
    }
    "docs/getting-started.md" = {
      content   = file("${path.module}/templates/getting-started.md")
      overwrite = false
    }
  }
}
```

## Examples

### Basic Repository

```hcl
module "basic_repo" {
  source = "HappyPathway/repo/github"
  
  name     = "my-project"
  repo_org = "MyOrganization"
}
```

### Repository with Protected Branches

```hcl
module "protected_repo" {
  source = "HappyPathway/repo/github"
  
  name     = "protected-project"
  repo_org = "MyOrganization"
  
  branch_protections = {
    main = {
      required_status_checks = true
      enforce_admins        = true
      required_reviews      = 2
    }
  }
}
```

### Repository with Managed Files

```hcl
module "managed_repo" {
  source = "HappyPathway/repo/github"
  
  name     = "managed-project"
  repo_org = "MyOrganization"
  
  managed_extra_files = {
    "README.md" = {
      content   = file("${path.module}/templates/readme.md")
      overwrite = true
    }
    "CONTRIBUTING.md" = {
      content   = file("${path.module}/templates/contributing.md")
      overwrite = false
    }
  }
}
```

## Testing

This module includes automated tests using Terraform's built-in testing framework:

```bash
terraform test
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

MIT License - see [LICENSE](LICENSE) for details


[![Terraform Validation](https://github.com/HappyPathway/terraform-github-repo/actions/workflows/terraform.yaml/badge.svg)](https://github.com/HappyPathway/terraform-github-repo/actions/workflows/terraform.yaml)


[![Modtest Dev](https://github.com/HappyPathway/terraform-github-repo/actions/workflows/modtest-dev.yaml/badge.svg)](https://github.com/HappyPathway/terraform-github-repo/actions/workflows/modtest-dev.yaml)

<!-- BEGIN_TF_DOCS -->
{{ .Content }}
<!-- END_TF_DOCS -->
