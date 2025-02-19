locals {
  repo_name = var.force_name ? var.name : "${var.name}-${formatdate("YYYYMMDD", timestamp())}"
  
  github_repo = var.create_repo ? github_repository.repo[0] : data.github_repository.existing[0]
}

resource "github_repository" "repo" {
  count                 = var.create_repo ? 1 : 0
  name                  = local.repo_name
  description           = var.github_repo_description
  visibility            = var.github_is_private ? "private" : "public"
  has_issues            = var.github_has_issues
  has_projects          = var.github_has_projects
  has_wiki              = var.github_has_wiki
  auto_init             = var.github_auto_init
  archive_on_destroy    = var.archive_on_destroy
  archived              = var.archived
  vulnerability_alerts  = var.vulnerability_alerts
  topics                = var.github_repo_topics
  homepage_url          = var.homepage_url
  gitignore_template    = var.gitignore_template
  is_template           = var.is_template

  allow_merge_commit     = var.github_allow_merge_commit
  allow_squash_merge     = var.github_allow_squash_merge
  allow_rebase_merge     = var.github_allow_rebase_merge
  allow_auto_merge       = var.github_allow_auto_merge
  delete_branch_on_merge = var.github_delete_branch_on_merge

  dynamic "template" {
    for_each = var.template_repo == null ? [] : ["*"]
    content {
      owner      = var.template_repo_org
      repository = var.template_repo
    }
  }

  dynamic "security_and_analysis" {
    for_each = var.security_and_analysis == null ? [] : ["*"]
    content {
      dynamic "advanced_security" {
        for_each = try(var.security_and_analysis.advanced_security, null) == null ? [] : ["*"]
        content {
          status = var.security_and_analysis.advanced_security.status
        }
      }
      dynamic "secret_scanning" {
        for_each = try(var.security_and_analysis.secret_scanning, null) == null ? [] : ["*"]
        content {
          status = var.security_and_analysis.secret_scanning.status
        }
      }
      dynamic "secret_scanning_push_protection" {
        for_each = try(var.security_and_analysis.secret_scanning_push_protection, null) == null ? [] : ["*"]
        content {
          status = var.security_and_analysis.secret_scanning_push_protection.status
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      auto_init,
      template
    ]
  }
}

data "github_repository" "existing" {
  count     = var.create_repo ? 0 : 1
  name      = var.name
  full_name = var.repo_org != null ? "${var.repo_org}/${var.name}" : var.name
}
