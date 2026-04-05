resource "aws_codebuild_project" "nextwork_build_project" {
  name          = var.project_name
  build_timeout = var.build_timeout
  service_role  = var.project_iam_role

  source {
    type = "CODEPIPELINE"
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = var.cloudwatch_group_name
      stream_name = var.cloudwatch_stream_name
    }
  }

}