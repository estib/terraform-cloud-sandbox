
# What is all this?

This module contains submodules that are useful for quickly spinning up cloud-based sandbox environments for tests, demos, etc. It's goal is to provide a toolset that lets you focus on what you're building rather than how or where to host it. 

## What is included today?

1. [EC2](https://github.com/estib/terraform-cloud-sandbox/tree/main/modules/ec2) - a submodule for creating EC2 instances in an AWS account.
2. [VPC](https://github.com/estib/terraform-cloud-sandbox/tree/main/modules/vpc) - a submodule for creating a VPC in an AWS account (useful for the EC2 submodule)

## What is planned for the future?

The author of this module plans to add the following features / submodules in the future. Feel free to [open new issues to request additional features](https://github.com/estib/terraform-cloud-sandbox/issues/new?assignees=estib&labels=enhancement&projects=&template=feature_request.md&title=). 

1. Similar submodules for GCP
2. Similar submodules for Azure
3. Submodules for creating simple Kubernetes clusters
4. Submodules for managing serverless functions (lambda, etc.)
5. Submodules for hosting simple websites on cloud object storage (S3 etc.)
