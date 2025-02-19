# Terraform GitHub Repository Module

A comprehensive Terraform module for managing GitHub repositories with advanced features like branch protection, file management, and team access control. You can use this module to create new repositories or manage existing ones.

## Features
- Create new repositories or manage existing ones
- Complete GitHub repository management
- Branch protection rules
- File content management
- Team access configuration
- Action secrets management
- Repository collaborator management
- Automated README generation
- Issue management

## Usage

### Creating a New Repository
```hcl
module "new_repository" {
  source = "HappyPathway/repo/github"
  
  name                     = "my-repository"
  repo_org                = "MyOrganization"
  create_repo             = true  # Default, can be omitted
  force_name              = true
  github_repo_description = "Repository description"
  github_repo_topics      = ["terraform", "automation"]
  github_is_private       = false
}
```

### Managing an Existing Repository
```hcl
module "existing_repository" {
  source = "HappyPathway/repo/github"
  
  name        = "existing-repository"
  repo_org    = "MyOrganization"
  create_repo = false  # Tell Terraform to manage existing repository
  
  # All other settings will be applied to the existing repository
  github_repo_topics = ["managed", "terraform"]
  github_has_issues = true
}
```

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

## Inputs

| Name | Description | Type | Required | Default |
|------|-------------|------|----------|---------|
| name | Repository name | string | Yes | - |
| repo_org | GitHub organization name | string | No | null |
| create_repo | Whether to create a new repository or manage existing | bool | No | true |
| force_name | Keep exact repository name (no date suffix) | bool | No | false |
| github_repo_description | Repository description | string | No | null |
| github_repo_topics | Repository topics | list(string) | No | [] |
| github_is_private | Make repository private | bool | No | true |
| // ...other inputs... |

## Outputs

| Name | Description |
|------|-------------|
| github_repo | All repository attributes (see details below) |
| ssh_clone_url | SSH clone URL |
| node_id | Repository node ID for GraphQL |
| full_name | Full repository name (org/repo) |
| repo_id | Repository ID |
| html_url | Repository web URL |
| http_clone_url | HTTPS clone URL |
| git_clone_url | Git protocol clone URL |
| visibility | Repository visibility (public/private) |
| default_branch | Default branch name |
| topics | Repository topics |
| template | Template repository info |

### Complete Repository Attributes

The `github_repo` output includes:

Basic Info:
- `name` - Repository name
- `full_name` - Full repository name (org/repo)
- `description` - Repository description
- `html_url` - GitHub web URL
- `ssh_clone_url` - SSH clone URL
- `http_clone_url` - HTTPS clone URL
- `git_clone_url` - Git protocol URL
- `visibility` - Public or private status

Settings:
- `topics` - Repository topics
- `has_issues` - Issue tracking enabled
- `has_projects` - Project boards enabled
- `has_wiki` - Wiki enabled
- `is_template` - Template repository status
- `allow_merge_commit` - Merge commit allowed
- `allow_squash_merge` - Squash merge allowed
- `allow_rebase_merge` - Rebase merge allowed
- `allow_auto_merge` - Auto-merge enabled
- `delete_branch_on_merge` - Branch deletion on merge

Additional Info:
- `default_branch` - Default branch name
- `archived` - Archive status
- `homepage_url` - Homepage URL if set
- `vulnerability_alerts` - Vulnerability alerts status
- `template` - Template repository details if used
- `gitignore_template` - .gitignore template if used
- `license_template` - License template if used

## Limitations and Important Notes

### Managing Existing Repositories
When managing existing repositories (`create_repo = false`):
- The repository must already exist in the specified organization
- You must have admin access to the repository
- Some settings may be read-only if they were set during repository creation
- Initial repository settings (like `auto_init`) are ignored
- Branch protection rules can only be added, not removed

### Error Cases
The module will fail if:
- When `create_repo = false` and the repository doesn't exist
- When `create_repo = false` and `repo_org` is not specified
- When trying to manage a repository you don't have admin access to
- When applying branch protection rules to a private repository without a GitHub Enterprise plan

### Best Practices
1. When managing existing repositories:
   - Start with `create_repo = false` and minimal settings
   - Gradually add configuration to avoid conflicts
   - Use `terraform plan` to verify changes
   - Consider using `lifecycle` blocks to ignore specific attributes

2. For new repositories:
   - Use `create_repo = true` (default)
   - Set `force_name = true` to maintain consistent naming
   - Configure all settings during initial creation

## Testing

This module includes automated tests that verify:
- Repository creation
- Data source lookups for existing repositories
- All output attributes

Run the tests using:
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
