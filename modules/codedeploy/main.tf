resource "aws_codedeploy_app" "nextwork_codedeploy" {
  compute_platform = var.compute_platform
  name             = var.name
}

resource "aws_codedeploy_deployment_group" "nextwork_deploy_group" {
  app_name               = aws_codedeploy_app.nextwork_codedeploy.name
  deployment_group_name  = var.deployment_group_name
  service_role_arn       = var.codedeploy_role_arn

  ec2_tag_filter {
    key   = "Name"
    type  = "KEY_AND_VALUE"
    value = var.ec2_tag_name
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}