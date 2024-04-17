locals {
  codeowners = length(var.additional_codeowners) > 0 ? flatten(["${var.repo_org}/${var.github_codeowners_team}", formatlist("${var.repo_org}/%s", var.additional_codeowners)]) : ["${var.repo_org}/${var.github_codeowners_team}"]
}
