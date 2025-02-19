locals {
  branch_protection_rules = {
    main = {
      pattern                 = var.github_default_branch
      enforce_admins          = var.github_enforce_admins_branch_protection
      allows_deletions        = false
      require_signed_commits  = var.require_signed_commits
      required_linear_history = true
      required_status_checks  = var.required_status_checks
      required_pull_request_reviews = {
        dismiss_stale_reviews           = var.github_dismiss_stale_reviews
        require_code_owner_reviews      = var.github_require_code_owner_reviews
        required_approving_review_count = var.github_required_approving_review_count
        pull_request_bypassers          = var.pull_request_bypassers
      }
    }
  }
}

resource "github_branch_protection" "protection" {
  for_each = local.branch_protection_rules

  repository_id           = local.repo_exists.node_id
  pattern                 = each.value.pattern
  enforce_admins          = each.value.enforce_admins
  allows_deletions        = try(each.value.allows_deletions, false)
  allows_force_pushes     = try(each.value.allows_force_pushes, false)
  require_signed_commits  = try(each.value.require_signed_commits, false)
  required_linear_history = try(each.value.required_linear_history, false)

  dynamic "required_status_checks" {
    for_each = each.value.required_status_checks != null ? [each.value.required_status_checks] : []
    content {
      strict   = try(required_status_checks.value.strict, true)
      contexts = required_status_checks.value.contexts
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = each.value.required_pull_request_reviews != null ? [each.value.required_pull_request_reviews] : []
    content {
      dismiss_stale_reviews           = try(required_pull_request_reviews.value.dismiss_stale_reviews, true)
      restrict_dismissals             = try(required_pull_request_reviews.value.restrict_dismissals, false)
      require_code_owner_reviews      = try(required_pull_request_reviews.value.require_code_owner_reviews, true)
      required_approving_review_count = try(required_pull_request_reviews.value.required_approving_review_count, 1)
      pull_request_bypassers          = try(required_pull_request_reviews.value.pull_request_bypassers, [])
    }
  }

  depends_on = [
    local.repo_exists,
    github_repository_file.codeowners,
    github_repository_file.extra_files,
    github_repository_file.managed_extra_files
  ]
}