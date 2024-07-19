locals {
  eks_oidc_provider     = replace(data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://", "")
  eks_oidc_provider_sub = "${local.eks_oidc_provider}:sub"
  eks_oidc_provider_arn = "arn:aws:iam::${var.aws_accid}:oidc-provider/${local.eks_oidc_provider}"
}

data "aws_eks_cluster" "eks_cluster" {
  name = var.eks_cluster
}

#IAM Policy Document to be used by the IAM Role
data "aws_iam_policy_document" "service_account_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = local.eks_oidc_provider_sub
      values   = ["system:serviceaccount:test-namespace:cloud-project-service-acc"]
    }

    principals {
      identifiers = [local.eks_oidc_provider_arn]
      type        = "Federated"
    }
  }
}

#IAM Role that will be assumed by the Kubernetes service account
resource "aws_iam_role" "iam_role" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.service_account_assume_role_policy.json
  tags               = {}
}