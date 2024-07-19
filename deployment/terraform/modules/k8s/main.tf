#namespace
resource "kubernetes_namespace" "example" {
  metadata {
    name = "test-namespace"
    annotations = {
      "iam.amazonaws.com/permitted" = ".*"
    }
  }
}

#K8S Service Account to utilize the IAM Role
resource "kubernetes_service_account" "service_account" {
  metadata {
    name      = "cloud-project-service-acc"
    namespace = "test-namespace"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.iam_role.arn
    }
  }
}
