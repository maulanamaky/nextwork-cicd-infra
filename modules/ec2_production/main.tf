resource "aws_instance" "nextwork_prod_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.nextwork_prod_securitygroup.id]

  iam_instance_profile = var.iam_instance_profile

  user_data = file("${path.module}/../../user-data-prod.sh")

  tags = {
    Name = var.ec2_name
  }
}
