output "public_dns" {
  value = "${aws_instance.kibana.public_dns}"
}

output "public_ip" {
  value = "${aws_instance.kibana.public_ip}"
}

output "private_dns" {
  value = "${aws_instance.kibana.private_dns}"
}

output "private_ip" {
  value = "${aws_instance.kibana.private_ip}"
}
