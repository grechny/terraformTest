resource "null_resource" "init_script" {

  # Define your variable
  variable "name" {
    type = string
  }

  triggers = {
    always = true
  }

  provisioner "local-exec" {
    command = <<-EOF
      base64encode $(templatefile("${path.module}/init-script.sh", {
        name = var.name
      })) > init-script.sh
    EOF
  }
}