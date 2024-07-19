variable "env" {
  description = "Environment"
  type        = string
}

variable "aws_accid" {
  description = "AWS Account ID"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "eks_cluster" {
  description = "EKS cluster name"
  type        = string
}

variable "iam_role_name" {
  description = "The name of the IAM role"
  type        = string
}
