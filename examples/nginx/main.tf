module "repository" {
  source = "../.."

  name                       = "nginx"
  scan_on_push               = var.scan_on_push
  untagged_image_expiry_days = var.untagged_image_expiry_days
}

module "import" {
  count  = length(var.source_tags)
  source = "figurate/docker-container/docker//modules/ecr"

  command    = ["push", "nginx", var.source_tags[count.index]]
  depends_on = [module.repository]
  rm         = false
}
