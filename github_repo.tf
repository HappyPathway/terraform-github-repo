locals {
  repo_name = var.force_name ? var.name : "${var.name}-${formatdate("YYYYMMDD", timestamp())}"
  
  github_repo = var.create_repo ? github_repository.repo[0] : data.github_repository.existing[0]
}

resource "github_repository" "repo" {
  count                  = var.create_repo ? 1 : 0
  name                   = local.repo_name
  description            = var.github_repo_description
  visibility             = var.github_is_private ? "private" : "public"
  auto_init              = var.github_auto_init
  allow_merge_commit     = var.github_allow_merge_commit
  allow_squash_merge     = var.github_allow_squash_merge
  allow_rebase_merge     = var.github_allow_rebase_merge
  archive_on_destroy     = var.archive_on_destroy
  delete_branch_on_merge = var.github_delete_branch_on_merge
  has_projects           = var.github_has_projects
  has_issues             = var.github_has_issues
  has_wiki               = var.github_has_wiki
  topics                 = var.github_repo_topics
  gitignore_template     = var.gitignore_template
  is_template            = var.is_template
  archived               = var.archived
  homepage_url           = var.homepage_url
  vulnerability_alerts   = var.vulnerability_alerts

  dynamic "template" {
    for_each = var.template_repo == null ? [] : ["*"]
    content {
      owner      = var.template_repo_org
      repository = var.template_repo
    }
  }
}

data "github_repository" "existing" {
  count       = var.create_repo ? 0 : 1
  name        = local.repo_name
  full_name   = var.repo_org != null ? "${var.repo_org}/${local.repo_name}" : local.repo_name
}
