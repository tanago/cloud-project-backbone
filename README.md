# Cloud Project Backbone

## What is it?

Basic configuration for a service that can be deployed on AWS. The service uses a IAM service account to access the resources on AWS securely.

### Features

#### Terraform

creates a database instance, EKS cluster and a namespace on that cluster to contain the application.

#### Kustomize

Hierarchical Kubernetes configuration for the service.

#### CI/CD

Github Actions - builds, tests and deploys the app to the cloud.

#### Skaffold

Different environments the app can be deployed to are configured as profiles. Works in conjuction with Kustomize. 

## High Availability/Disaster Recovery

### Rolling updates

In case of deployment - pods are configured to be updated one by one instead of terminating them all to minimise service downtime.

### Continous health checks

The service is tested every X seconds for health status

### Minimum service instances

A disruption budget is configured to always maintain at least 2 instances of the service.

### In case of failure

The service is restarted in every case (if it crashed or a process went wrong)

## Database

An RDS instance is created and its credentials are stored as sealed secrets for the service to use