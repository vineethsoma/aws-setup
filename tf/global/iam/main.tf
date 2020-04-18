terraform {
    backend "s3" {}
}

provider "aws" {
    region = "us-east-1"
}

module "groups" {
  source = "./groups" 
}
