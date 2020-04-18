remote_state {
    backend = "s3"
    config = {
        bucket         = "terraform-state-vsoma"
        key            = "${path_relative_to_include()}/terraform.tfstate"
        region         = "us-east-1"
        encrypt        = true
        dynamodb_table = "terragrunt-locks"
    }   
}

# For more info on HCL2 - https://github.com/gruntwork-io/terragrunt/blob/master/_docs/migration_guides/upgrading_to_terragrunt_0.19.x.md