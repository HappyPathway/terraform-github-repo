# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file
resource "github_repository_file" "codeowners" {
  count               = var.create_codeowners ? 1 : 0
  repository          = github_repository.repo.name
  branch              = var.github_default_branch
  file                = "CODEOWNERS"
  content             = templatefile("${path.module}/templates/CODEOWNERS", { codeowners = local.codeowners })
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      content,
      branch
    ]
  }
}


data "github_repository" "template_repo" {
  count     = var.template_repo == null ? 0 : 1
  full_name = "${var.template_repo_org}/${var.template_repo}"
}

data "github_ref" "ref" {
  count      = var.template_repo == null ? 0 : 1
  owner      = var.template_repo_org
  repository = var.template_repo
  ref        = "heads/${element(data.github_repository.template_repo, 0).default_branch}"
}

locals {
  extra_files = concat(
    var.extra_files,
    var.template_repo == null ? [] : [
      {
        path    = ".TEMPLATE_SHA",
        content = data.github_ref.ref[0].sha
      }
    ]
  )
}

resource "github_repository_file" "extra_files" {
  for_each            = tomap({ for file in local.extra_files : "${element(split("/", file.path), length(split("/", file.path)) - 1)}" => file })
  repository          = github_repository.repo.name
  branch              = var.github_default_branch
  file                = each.value.path
  content             = each.value.content
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      content,
      branch
    ]
  }
}

resource "github_repository_file" "managed_extra_files" {
  for_each            = tomap({ for file in var.managed_extra_files : "${element(split("/", file.path), length(split("/", file.path)) - 1)}" => file })
  repository          = github_repository.repo.name
  branch              = var.github_default_branch
  file                = each.value.path
  content             = each.value.content
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      branch
    ]
  }
}
