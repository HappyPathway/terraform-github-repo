variable "name" {
  description = "Name of the terraform workspace and optionally github repo"
}

variable "repo_org" {
  default = null
}

variable "github_codeowners_team" {
  default = "terraform-reviewers"
}

variable "github_repo_description" {
  default = "Terraform Workspace"
}

variable "github_repo_topics" {
  description = "Github Repo Topics"
  type        = list(any)
  default     = []
}

variable "github_push_restrictions" {
  description = "Github Push Restrictions"
  type        = list(any)
  default     = []
}
variable "github_is_private" {
  default = true
}
variable "github_auto_init" {
  default = true
}
variable "github_allow_merge_commit" {
  default = false
}
variable "github_allow_squash_merge" {
  default = true
}
variable "github_allow_rebase_merge" {
  default = false
}
variable "github_delete_branch_on_merge" {
  default = true
}
variable "github_has_projects" {
  default = true
}
variable "github_has_issues" {
  default = false
}
variable "github_has_wiki" {
  default = true
}
variable "github_default_branch" {
  default = "main"
}
variable "github_required_approving_review_count" {
  default = 1
}
variable "github_require_code_owner_reviews" {
  default = true
}
variable "github_dismiss_stale_reviews" {
  default = true
}
variable "github_enforce_admins_branch_protection" {
  default = true
}

variable "additional_codeowners" {
  description = "Enable adding of Codeowner Teams"
  type        = list(any)
  default     = []
}

variable "prefix" {
  default = null
}

variable "force_name" {
  description = "Force Naming of Repo. If forced, archive management will not operate on this repo"
  default     = false
}

variable "github_org_teams" {
  type        = list(any)
  description = "provide module with list of teams so that module does not need to look them up"
  default     = null
}

variable "template_repo_org" {
  default = null
}

variable "template_repo" {
  default = null
}

variable "is_template" {
  default = false
}


variable "admin_teams" {
  description = "Admin Teams"
  type        = list(any)
  default     = []
}


variable "required_status_checks" {
  description = "Required Status Checks"
  type        = list(any)
  default     = []
}

variable "archived" {
  default = false
}

variable "secrets" {
  type = list(object({
    name  = string,
    value = string
  }))
  default     = []
  description = "Github Action Secrets"
}

variable "vars" {
  type = list(object({
    name  = string,
    value = string
  }))
  default     = []
  description = "Github Action Vars"
}

variable "extra_files" {
  type = list(object({
    path    = string,
    content = string
  }))
  default     = []
  description = "Extra Files"
}


variable "pull_request_bypassers" {
  default = []
  type    = list(any)
}

variable "create_codeowners" {
  default = true
  type    = bool
}

variable "enforce_prs" {
  default = true
  type    = bool
}

variable collaborators {
  type = map(string)
  description = "list of repo callaborators"
  default = {}
}
