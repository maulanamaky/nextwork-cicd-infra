variable "name" {
    type = string
}

variable "codepipeline_role_arn" {
    type = string
}

variable "s3_bucket_name" {
    type = string
}

variable "codeconnection_arn" {
    type = string
}

variable "github_repo_id" {
    type = string
}

variable "github_branch" {
    type = string
}

variable "codebuild_name" {
    type = string
}

variable "codedeploy_app_name" {
    type = string
}

variable "codedeploy_group_name" {
    type = string
}