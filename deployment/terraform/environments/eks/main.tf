locals {
  environment = "eks"
  aws_accid   = ""
  region      = "eu-central-1"
  eks_cluster = ""
}

terraform {
  backend "s3" {
    bucket = "cloud-project-terraform"
    key    = "state.tfstate"
    region = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt = "true"
  }
}

provider "aws" {
  region = local.region
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "rds" {
  source = "../../modules/rds"
}


module "iam" {
  source = "../../modules/iam"
}


module "k8s" {
  source = "../../modules/k8s"
}
