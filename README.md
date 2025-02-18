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

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| github | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| github | >= 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Repository name | `string` | n/a | yes |
| repo_org | GitHub organization name | `string` | n/a | yes |
| force_name | Force the repository name | `bool` | `false` | no |
| github_repo_description | Repository description | `string` | `""` | no |
| github_repo_topics | Repository topics | `list(string)` | `[]` | no |
| github_is_private | Private repository flag | `bool` | `true` | no |
| github_has_issues | Enable issues | `bool` | `true` | no |
| github_has_projects | Enable projects | `bool` | `false` | no |
| github_has_wiki | Enable wiki | `bool` | `false` | no |
| vulnerability_alerts | Enable vulnerability alerts | `bool` | `true` | no |
| gitignore_template | GitIgnore template name | `string` | `null` | no |
| managed_extra_files | Map of files to manage in the repository | `map(object({ content = string, overwrite = bool }))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| github_repo | The complete GitHub repository object |
| repo_full_name | The full name of the repository (org/name) |

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