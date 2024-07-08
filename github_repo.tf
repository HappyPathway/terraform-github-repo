locals {
  repo_name = var.force_name ? var.name : "${var.name}-${formatdate("YYYYMMDD", timestamp())}"
}

moved {
  from = "github_repository.repo"
  to   = "github_repository.repo_force_name"
}

resource "github_repository" "repo_force_name" {
  count                  = var.force_name ? 1 : 0
  name                   = local.repo_name
  description            = var.github_repo_description
  visibility             = var.github_is_private ? "private" : "public"
  auto_init              = var.github_auto_init
  allow_merge_commit     = var.github_allow_merge_commit
  allow_squash_merge     = var.github_allow_squash_merge
  allow_rebase_merge     = var.github_allow_rebase_merge
  archive_on_destroy     = true
  delete_branch_on_merge = var.github_delete_branch_on_merge
  has_projects           = var.github_has_projects
  has_issues             = var.github_has_issues
  has_wiki               = var.github_has_wiki
  topics                 = var.github_repo_topics
  gitignore_template     = "Terraform"
  is_template            = var.is_template
  archived               = var.archived
  lifecycle {
    ignore_changes = [
      has_issues,
      has_projects,
      has_wiki
    ]
  }
  dynamic "template" {
    # A bogus map for a conditional block
    for_each = var.template_repo == null ? [] : ["*"]
    content {
      owner      = var.template_repo_org
      repository = var.template_repo
      # include_all_branches = var.template_include_all_branches
    }
  }
}


resource "github_repository" "repo_ignore_name_change" {
  count                  = var.force_name ? 0 : 1
  name                   = local.repo_name
  description            = var.github_repo_description
  visibility             = var.github_is_private ? "private" : "public"
  auto_init              = var.github_auto_init
  allow_merge_commit     = var.github_allow_merge_commit
  allow_squash_merge     = var.github_allow_squash_merge
  allow_rebase_merge     = var.github_allow_rebase_merge
  archive_on_destroy     = true
  delete_branch_on_merge = var.github_delete_branch_on_merge
  has_projects           = var.github_has_projects
  has_issues             = var.github_has_issues
  has_wiki               = var.github_has_wiki
  topics                 = var.github_repo_topics
  gitignore_template     = "Terraform"
  is_template            = var.is_template
  archived               = var.archived
  lifecycle {
    ignore_changes = [
      name,
      has_issues,
      has_projects,
      has_wiki
    ]
  }
  dynamic "template" {
    # A bogus map for a conditional block
    for_each = var.template_repo == null ? [] : ["*"]
    content {
      owner      = var.template_repo_org
      repository = var.template_repo
      # include_all_branches = var.template_include_all_branches
    }
  }
}
