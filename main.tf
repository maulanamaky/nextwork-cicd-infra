module "key" {
  source = "./modules/key"

  key_name   = "nextwork-key"
  public_key = var.public_key
}

module "iam" {
  source = "./modules/iam"

  s3_bucket_arn         = module.s3.bucket_arn
  cloudwatch_log_arn    = module.cloudwatch.log_group_arn
  codeartifact_repo_arn = module.codeartifact.repo_arn
  codeconnection_arn = module.codeconnection.codeconnection_arn
  codebuild_arn = module.codebuild.codebuild_arn
  codedeploy_arn = module.codedeploy.codedeploy_arn
}

module "ec2" {
  source = "./modules/ec2"

  ec2_name      = "nextwork-instance"
  key_name      = module.key.key_name
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t3.micro"

  iam_instance_profile = module.iam.iam_instance_profile_name
}

module "codeartifact" {
  source = "./modules/codeartifact"

  domain_name     = "nextwork"
  repository_name = "nextwork-devops-cicd"

  ec2_role_arn = module.iam.ec2_role_arn
  codebuild_role_arn = module.iam.codebuild_role_arn
}

module "codeconnection" {
  source = "./modules/codeconnection"

  connection_name = "nextwork-connection"
  provider_type   = "Github"
}

module "codebuild" {
  source = "./modules/codebuild"

  codebuild_name     = "nextwork-devops-cicd"
  build_timeout      = 5
  codebuild_iam_role = module.iam.codebuild_iam_role_arn

  cloudwatch_group_name = module.cloudwatch.group_name
  cloudwatch_stream_name = module.cloudwatch.stream_name
}

module "s3" {
  source = "./modules/s3"

  bucket            = "nextwork-bucket"
  versioning_status = "Enabled"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

module "codedeploy" {
  source = "./modules/codedeploy"

  compute_platform = "Server"
  name = "Nextwork"
  deployment_group_name = "nextwork-deploy-group"
  codedeploy_role_arn = module.iam.codedeploy_role_arn
  ec2_tag_value = module.ec2_production.ec2_tag_name
}

module "codepipeline" {
  source = "./modules/codepipeline"

  name = "nextwork-pipeline"
  codepipeline_role_arn = module.iam.codepipeline_role_arn
  s3_bucket_name = module.s3.bucket_name
  codeconnection_arn = module.codeconnection.codeconnection_arn
  github_repo_id = "maulanamaky/nextwork-web-project"
  github_branch = "main"
  codebuild_name = module.codebuild.codebuild_name
  codedeploy_app_name = module.codedeploy.codedeploy_app_name
  codedeploy_group_name = module.codedeploy.codedeploy_group_name
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  group_name = "nextwork-log-group"
  stream_name = "nextwork-log-stream"
}

module "ec2-prod" {
  source = "./modules/ec2_production"

  ec2_name      = "nextwork-prod-instance"
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t3.micro"

  iam_instance_profile = module.iam.prod_iam_instance_profile_name
}