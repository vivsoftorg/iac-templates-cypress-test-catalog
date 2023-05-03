resource "null_resource" "demo" {
  provisioner "local-exec" {
    command = "echo \"Hello world from $Name\""
    environment = {
      Name = "juned"
    }
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}