// EC2

resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "ec2.amazonaws.com"
          }
      },
    ]
  })
}

resource "aws_iam_role_policy" "ec2_role_policy" {
  name = "ec2-policy"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
            Effect = "Allow",
            Action = [
                "codeartifact:GetAuthorizationToken",
                "codeartifact:GetRepositoryEndpoint",
                "codeartifact:ReadFromRepository"
            ],
            Resource = var.codeartifact_repo_arn
        },
        {
            Effect = "Allow",
            Action = [
                "codedeploy:*"
            ],
            Resource = var.codedeploy_arn
        },
        {
            Effect = "Allow",
            Action = "sts:GetServiceBearerToken",
            Resource = "*",
            Condition = {
                "StringEquals" = {
                    "sts:AWSServiceName": "codeartifact.amazonaws.com"
                }
            }
        }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_iam_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_role.name
}

// EC2 PRODUCTION

resource "aws_iam_role" "ec2_prod_role" {
  name = "ec2-prod-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "ec2.amazonaws.com"
          }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_prod_role_policy" {
  role       = aws_iam_role.ec2_prod_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

resource "aws_iam_instance_profile" "ec2_prod_iam_profile" {
  name = "ec2-prod-profile"
  role = aws_iam_role.ec2_prod_role.name
}

// CODEBUILD

resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = ""
          Principal = {
            Service = "codebuild.amazonaws.com"
          }
      },
    ]
  })
}

resource "aws_iam_role_policy" "codebuild_role_policy" {
  name = "codebuild-policy"
  role = aws_iam_role.codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
          Effect = "Allow"
          Action = [
            "codeartifact:GetAuthorizationToken",
            "codeartifact:GetRepositoryEndpoint",
            "codeartifact:ReadFromRepository"
          ]
          Resource = var.codeartifact_repo_arn
      },
            {
          Effect = "Allow"
          Action = [
            "codestar-connections:UseConnection"
          ]
          Resource = var.codeconnection_arn
      },
      {
          Effect = "Allow"
          Action = [
            "logs:PutLogEvents",
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
          ]
          Resource = [
            var.cloudwatch_log_arn,
            "${var.cloudwatch_log_arn}:*"
          ]
      },
      {
          Effect = "Allow"
          Action = [
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:PutObject"
          ]
          Resource = "${var.s3_bucket_arn}/*"
      },
      {
          Effect = "Allow"
          Action = [
            "sts:GetServiceBearerToken"
          ]
          Resource = "*"
          Condition = {
            StringEquals = {
              "sts:AWSServiceName": "codeartifact.amazonaws.com"
            }
          }
      }
    ]
  })
}

// CODEDEPLOY

resource "aws_iam_role" "codedeploy_role" {
  name = "codedeploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "codedeploy.amazonaws.com"
          }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_role_policy" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

// CODEPIPELINE

resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "codepipeline.amazonaws.com"
          }
      },
    ]
  })
}

resource "aws_iam_role_policy" "codepipeline_role_policy" {
  name = "codepipeline-policy"
  role = aws_iam_role.codepipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
            Effect = "Allow",
            Action = [
                "codestar-connections:UseConnection",
            ],
            Resource = var.codeconnection_arn
        },
        {
            Effect = "Allow",
            Action = [
                "codebuild:*",
            ],
            Resource = var.codebuild_arn
        },
        {
            Effect = "Allow",
            Action = [
                "codedeploy:*"
            ],
            Resource = var.codedeploy_arn
        },
        {
            Effect = "Allow",
            Action = [
                "s3:GetObject",
                "s3:PutObject"
            ],
            Resource = "${var.s3_bucket_arn}/*"
        },
                {
            Effect = "Allow",
            Action = [
                "s3:GetBucketVersioning"
            ],
            Resource = var.s3_bucket_arn
        },
    ]
  })
}

