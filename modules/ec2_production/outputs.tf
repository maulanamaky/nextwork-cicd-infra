output "ec2_tag_name" {
    value = aws_instance.nextwork_prod_instance.tags["Name"]
}