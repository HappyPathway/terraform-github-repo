# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file
resource "github_repository_file" "codeowners" {
  count = var.create_codeowners ? 1 : 0
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

resource "github_repository_file" "extra_files" {
  for_each            = tomap({ for file in var.extra_files : "${element(split("/", file.path), length(split("/", file.path)) - 1)}" => file })
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
