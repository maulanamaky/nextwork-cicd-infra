resource "aws_instance" "nextwork_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_name

  vpc_security_group_ids = [aws_security_group.nextwork_securitygroup.id]

  iam_instance_profile = var.iam_instance_profile

  user_data = file("${path.module}/../../user-data.sh")

  tags = {
    Name = var.ec2_name
  }
}
