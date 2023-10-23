output "entrypoint" {
  value = var.instance_cnt == 0 ? "" : "ssh ${var.user}@${aws_instance.test-env-instance[0].public_ip} -i ~/.ssh/${var.creator}-${var.test_env_name}-key.pem"
}

output "instance_info" {
  value = one(aws_instance.test-env-instance)
}

output "ssh_to" {
  value = var.instance_cnt == 1 ? "${var.user}@${aws_instance.test-env-instance[0].public_ip}" : ""
}