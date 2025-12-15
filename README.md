# AWS Infrastructure Using Terraform

This repository contains Terraform configurations that automate the creation of a complete AWS infrastructure environment. It provisions networking, compute, storage, database, security, and associated services required to run a cloud-based application in a scalable and reliable way.

## Architecture Summary

The architecture consists of the following major components:

1. VPC with public and private subnets across multiple Availability Zones
2. Internet Gateway and Route Tables for public routing
3. EC2 instance placed in a public subnet
4. RDS MySQL instance placed inside highly available private subnets
5. S3 buckets for application assets, CodeDeploy artifacts, and Lambda functions
6. IAM role for EC2 access to S3

## Architecture Overview

```                       ┌────────────────────────────┐
                          │          Route 53          │
                          │  DNS (app.example.com)     │
                          └─────────────┬──────────────┘
                                        │
                                        ▼
                          ┌────────────────────────────┐
                          │   Application Load Balancer│
                          │   (HTTPS :443, ACM Cert)   │
                          │   Public Subnets (3 AZs)   │
                          └─────────────┬──────────────┘
                                        │
                        ┌───────────────┼────────────────┐
                        │               │                │
                        ▼               ▼                ▼
        ┌────────────────────┐ ┌────────────────────┐ ┌────────────────────┐
        │  EC2 Auto Scaling  │ │  EC2 Auto Scaling  │ │  EC2 Auto Scaling  │
        │  App Instances     │ │  App Instances     │ │  App Instances     │
        │  Private Subnet AZ1│ │  Private Subnet AZ2│ │  Private Subnet AZ3│
        └─────────┬──────────┘ └─────────┬──────────┘ └─────────┬──────────┘
                  │                      │                      │
                  │                      │                      │
                  ▼                      ▼                      ▼
        ┌──────────────────────────────────────────────────────────┐
        │                     Amazon RDS (MySQL)                   │
        │              Private Subnets (Multi-AZ)                  │
        └──────────────────────────────────────────────────────────┘

────────────────────────────────────────────────────────────────────────

         ┌───────────────────────┐
         │        Amazon SNS     │
         │   Password Reset Topic│
         └───────────┬───────────┘
                     │
                     ▼
         ┌───────────────────────┐
         │     AWS Lambda        │
         │  Password Reset Logic │
         └───────────┬───────────┘
                     │
         ┌───────────┼───────────┐
         │           │           │
         ▼           ▼           ▼
 ┌─────────────┐ ┌─────────────┐ ┌─────────────────┐
 │  DynamoDB   │ │ Amazon SES  │ │ CloudWatch Logs │
 │  Token Store│ │ Email Notify│ │   & Metrics     │
 └─────────────┘ └─────────────┘ └─────────────────┘

────────────────────────────────────────────────────────────────────────

   ┌──────────────────────────────────────────────────────────────┐
   │                            Amazon S3                         │
   │  - Web App Assets Bucket                                     │
   │  - CodeDeploy Artifacts                                      │
   │  - Lambda Deployment Packages                                │
   └───────────────────────────────────────────────────────────-──┘



## What This Infrastructure Includes
🌐 Networking

Custom VPC with a dedicated CIDR block

Three public subnets across multiple Availability Zones for internet-facing components

Three private subnets for application workloads, isolated from direct internet access

Internet Gateway for inbound and outbound public traffic

NAT Gateway enabling secure outbound internet access from private subnets

Route tables configured to enforce proper traffic flow between tiers

⚖️ Load Balancing & DNS

Application Load Balancer (ALB) deployed in public subnets

HTTPS listener (port 443) secured with an ACM SSL certificate

Route 53 DNS record mapping a custom domain to the ALB

ALB security group allowing only HTTPS traffic from the internet

🖥️ Compute (Application Tier)

EC2 instances running in private subnets

Auto Scaling Group for high availability and horizontal scalability

Security groups enforcing least-privilege access between ALB, application, and database layers

Outbound internet access via NAT Gateway for updates and external API calls

🗄️ Data Layer

Amazon RDS (MySQL) deployed in private subnets

Multi-AZ configuration for fault tolerance

No public accessibility, ensuring the database is reachable only from the application tier

⚡ Serverless & Event-Driven Components

Amazon SNS topic for asynchronous events (e.g., password reset requests)

AWS Lambda function triggered by SNS

Amazon DynamoDB table for temporary token storage

Amazon SES integration for sending transactional emails

Fully decoupled, event-driven workflow

📦 Storage & Deployment

Amazon S3 buckets for:

Web application assets

AWS CodeDeploy application revisions

Lambda deployment packages

Designed to support CI/CD pipelines and versioned deployments

🔐 Security & Best Practices

Private subnets for sensitive workloads

Encrypted communication via HTTPS

IAM-based access control between services

Separation of concerns across network, compute, and data layers

Infrastructure defined as code using Terraform modules

## How to Use This Project
1. Install Prerequisites

You will need:

Terraform ≥ 1.0

AWS CLI configured with valid credentials

An AWS account with appropriate permissions

2. Initialize Terraform
`terraform init`

3. Validate Configuration
`terraform validate`

4. Preview the Infrastructure Plan
`terraform plan`

5. Apply the Infrastructure
`terraform apply`
