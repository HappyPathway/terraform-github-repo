# terraform-github-repo
Module to automate creation of
* github related resources
  * repo
  * default branch
  * branch protection rule for main branch
  * default codeowners and backend.tf file
  * team access

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.2.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_secret.secret](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_variable.variable](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [github_branch.branch](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch_default.default_main_branch](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_branch_protection.main](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_repository.repo](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_collaborator.collaborators](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborator) | resource |
| [github_repository_file.codeowners](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.extra_files](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.managed_extra_files](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_team_repository.admin](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
| [github_organization_teams.root_teams](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/organization_teams) | data source |
| [github_ref.ref](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/ref) | data source |
| [github_repository.template_repo](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repository) | data source |
| [github_user.pull_request_bypassers](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_codeowners"></a> [additional\_codeowners](#input\_additional\_codeowners) | Enable adding of Codeowner Teams | `list(any)` | `[]` | no |
| <a name="input_admin_teams"></a> [admin\_teams](#input\_admin\_teams) | Admin Teams | `list(any)` | `[]` | no |
| <a name="input_archive_on_destroy"></a> [archive\_on\_destroy](#input\_archive\_on\_destroy) | n/a | `bool` | `true` | no |
| <a name="input_archived"></a> [archived](#input\_archived) | n/a | `bool` | `false` | no |
| <a name="input_collaborators"></a> [collaborators](#input\_collaborators) | list of repo callaborators | `map(string)` | `{}` | no |
| <a name="input_create_codeowners"></a> [create\_codeowners](#input\_create\_codeowners) | n/a | `bool` | `true` | no |
| <a name="input_enforce_prs"></a> [enforce\_prs](#input\_enforce\_prs) | n/a | `bool` | `true` | no |
| <a name="input_extra_files"></a> [extra\_files](#input\_extra\_files) | Extra Files | <pre>list(object({<br>    path    = string,<br>    content = string<br>  }))</pre> | `[]` | no |
| <a name="input_force_name"></a> [force\_name](#input\_force\_name) | Force Naming of Repo. If forced, archive management will not operate on this repo | `bool` | `false` | no |
| <a name="input_github_allow_merge_commit"></a> [github\_allow\_merge\_commit](#input\_github\_allow\_merge\_commit) | n/a | `bool` | `false` | no |
| <a name="input_github_allow_rebase_merge"></a> [github\_allow\_rebase\_merge](#input\_github\_allow\_rebase\_merge) | n/a | `bool` | `false` | no |
| <a name="input_github_allow_squash_merge"></a> [github\_allow\_squash\_merge](#input\_github\_allow\_squash\_merge) | n/a | `bool` | `true` | no |
| <a name="input_github_auto_init"></a> [github\_auto\_init](#input\_github\_auto\_init) | n/a | `bool` | `true` | no |
| <a name="input_github_codeowners_team"></a> [github\_codeowners\_team](#input\_github\_codeowners\_team) | n/a | `string` | `"terraform-reviewers"` | no |
| <a name="input_github_default_branch"></a> [github\_default\_branch](#input\_github\_default\_branch) | n/a | `string` | `"main"` | no |
| <a name="input_github_delete_branch_on_merge"></a> [github\_delete\_branch\_on\_merge](#input\_github\_delete\_branch\_on\_merge) | n/a | `bool` | `true` | no |
| <a name="input_github_dismiss_stale_reviews"></a> [github\_dismiss\_stale\_reviews](#input\_github\_dismiss\_stale\_reviews) | n/a | `bool` | `true` | no |
| <a name="input_github_enforce_admins_branch_protection"></a> [github\_enforce\_admins\_branch\_protection](#input\_github\_enforce\_admins\_branch\_protection) | n/a | `bool` | `true` | no |
| <a name="input_github_has_issues"></a> [github\_has\_issues](#input\_github\_has\_issues) | n/a | `bool` | `false` | no |
| <a name="input_github_has_projects"></a> [github\_has\_projects](#input\_github\_has\_projects) | n/a | `bool` | `true` | no |
| <a name="input_github_has_wiki"></a> [github\_has\_wiki](#input\_github\_has\_wiki) | n/a | `bool` | `true` | no |
| <a name="input_github_is_private"></a> [github\_is\_private](#input\_github\_is\_private) | n/a | `bool` | `true` | no |
| <a name="input_github_org_teams"></a> [github\_org\_teams](#input\_github\_org\_teams) | provide module with list of teams so that module does not need to look them up | `list(any)` | `null` | no |
| <a name="input_github_push_restrictions"></a> [github\_push\_restrictions](#input\_github\_push\_restrictions) | Github Push Restrictions | `list(any)` | `[]` | no |
| <a name="input_github_repo_description"></a> [github\_repo\_description](#input\_github\_repo\_description) | n/a | `any` | `null` | no |
| <a name="input_github_repo_topics"></a> [github\_repo\_topics](#input\_github\_repo\_topics) | Github Repo Topics | `list(any)` | `[]` | no |
| <a name="input_github_require_code_owner_reviews"></a> [github\_require\_code\_owner\_reviews](#input\_github\_require\_code\_owner\_reviews) | n/a | `bool` | `true` | no |
| <a name="input_github_required_approving_review_count"></a> [github\_required\_approving\_review\_count](#input\_github\_required\_approving\_review\_count) | n/a | `number` | `1` | no |
| <a name="input_is_template"></a> [is\_template](#input\_is\_template) | n/a | `bool` | `false` | no |
| <a name="input_managed_extra_files"></a> [managed\_extra\_files](#input\_managed\_extra\_files) | Managed Extra Files. Changes to Content will be updated | <pre>list(object({<br>    path    = string,<br>    content = string<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the terraform workspace and optionally github repo | `any` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `any` | `null` | no |
| <a name="input_pull_request_bypassers"></a> [pull\_request\_bypassers](#input\_pull\_request\_bypassers) | n/a | `list(any)` | `[]` | no |
| <a name="input_repo_org"></a> [repo\_org](#input\_repo\_org) | n/a | `any` | `null` | no |
| <a name="input_required_status_checks"></a> [required\_status\_checks](#input\_required\_status\_checks) | Required Status Checks<br>required\_status\_checks supports the following arguments:<br><br>strict: (Optional) Require branches to be up to date before merging. Defaults to false.<br>contexts: (Optional) The list of status checks to require in order to merge into this branch. <br>No status checks are required by default.<br>Note: This attribute can contain multiple string patterns. If specified, usual value is the job name. <br>Otherwise, the job id is defaulted to. For workflows that use matrixes, append the matrix name to the <br>value using the following pattern (<matrix\_value>[, <matrix\_value>]). Matrixes should be specified <br>based on the order of matrix properties in the workflow file. See GitHub Documentation for more <br>information. For workflows that use reusable workflows, <br>the pattern is <initial\_workflow.jobs.job.[name/id]> / <reused-workflow.jobs.job.[name/id]>. <br>This can extend multiple levels. | <pre>object({<br>    contexts = list(string)<br>    strict   = optional(bool, false)<br>  })</pre> | `null` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Github Action Secrets | <pre>list(object({<br>    name  = string,<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_template_repo"></a> [template\_repo](#input\_template\_repo) | n/a | `any` | `null` | no |
| <a name="input_template_repo_org"></a> [template\_repo\_org](#input\_template\_repo\_org) | n/a | `any` | `null` | no |
| <a name="input_vars"></a> [vars](#input\_vars) | Github Action Vars | <pre>list(object({<br>    name  = string,<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_vulnerability_alerts"></a> [vulnerability\_alerts](#input\_vulnerability\_alerts) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_repo"></a> [github\_repo](#output\_github\_repo) | n/a |
<!-- END_TF_DOCS -->