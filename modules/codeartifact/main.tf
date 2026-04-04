resource "aws_codeartifact_domain" "nextwork_artifact_domain" {
  domain = var.domain_name
}

resource "aws_codeartifact_domain_permissions_policy" "nextwork_artifact_domain_policy" {
  domain          = aws_codeartifact_domain.nextwork_artifact_domain.domain
  policy_document = jsonencode({
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            var.ec2_role_arn,
            var.codebuild_role_arn
          ]
        }
        Action   = ["codeartifact:*"]
        Resource = [aws_codeartifact_domain.nextwork_artifact_domain.arn]
      }
    ]
  })
}

resource "aws_codeartifact_repository" "nextwork_artifact_repo" {
  repository = var.repository_name
  domain     = aws_codeartifact_domain.nextwork_artifact_domain.domain
  external_connections {
    external_connection_name = "public:maven-central"
  }
}

resource "aws_codeartifact_repository_permissions_policy" "nextwork_artifact_repo_policy" {
  repository      = aws_codeartifact_repository.nextwork_artifact_repo.repository
  domain          = aws_codeartifact_domain.nextwork_artifact_domain.domain
  policy_document = jsonencode({
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            var.ec2_role_arn,
            var.codebuild_role_arn
          ]
        }
        Action   = ["codeartifact:ReadFromRepository"]
        Resource = [aws_codeartifact_repository.nextwork_artifact_repo.arn]
      }
    ]
  })
}