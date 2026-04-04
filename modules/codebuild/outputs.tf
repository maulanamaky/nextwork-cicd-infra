output "codebuild_name" {
    value = aws_codebuild_project.nextwork_build_project.name
}

output "codebuild_arn" {
    value = aws_codebuild_project.nextwork_build_project.arn
}