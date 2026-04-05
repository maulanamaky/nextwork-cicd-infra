output "codedeploy_app_name" {
    value = aws_codedeploy_app.nextwork_codedeploy.name
}

output "codedeploy_group_name" {
    value = aws_codedeploy_deployment_group.nextwork_deploy_group.deployment_group_name
}