data "local_file" "init_script" {
  content  = templatefile("${path.module}/init-script.sh.tpl", {
    NAME = var.name
  })
  filename = "${path.module}/init-script.sh"
}