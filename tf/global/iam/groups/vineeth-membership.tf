resource "aws_iam_user_group_membership" "vineeth-membership" {
    user    = "vineeth"
    groups  = [ 
        aws_iam_group.iam-admin.name 
    ]
}