resource "aws_iam_group" "iam-admin" {
  name = "IAMAdmin"
  path = "/"
}

resource "aws_iam_group_policy" "iam-admin-terraform-backend-access" {
  name  = "terraform-backend-access"
  group = aws_iam_group.iam-admin.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1587232039000",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:CreateBucket",
                "s3:GetBucketVersioning",
                "s3:ListObject",
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::terraform-state-vsoma",
                "arn:aws:s3:::terraform-state-vsoma/*"
            ]
        },
        {
            "Sid": "Stmt1587232093000",
            "Effect": "Allow",
            "Action": [
                "dynamodb:DescribeTable",
                "dynamodb:CreateTable",
                "dynamodb:GetItem",
                "dynamodb:PutItem",
                "dynamodb:DeleteItem"
            ],
            "Resource": [
                "arn:aws:dynamodb:*:*:table/terragrunt-locks"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_group_policy" "iam-admin-iam-group-access" {
  name  = "iam-group-access"
  group = aws_iam_group.iam-admin.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1587233261000",
            "Effect": "Allow",
            "Action": [
                "iam:GetGroup",
                "iam:CreateGroup",
                "iam:GetGroupPolicy",
                "iam:CreateGroupPolicy",
                "iam:PutGroupPolicy",
                "iam:UpdateGroup"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}