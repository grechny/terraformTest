resource "null_resource" "init_script" {

  triggers = {
    always = true
  }

  provisioner "local-exec" {
    command = <<-EOF
      base64encode $(templatefile("${path.module}/init-script.sh", {
        name = var.name
      })) > ${path.module}/init-script-modified.sh
    EOF
  }
}