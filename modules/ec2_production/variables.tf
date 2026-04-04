variable "ami" {
    type = string
    default = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

variable "instance_type" {
    type = string
    default = "t3.micro"
}

variable "ec2_name" {
    type = string
}

variable "iam_instance_profile" {
    type = string
}