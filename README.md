# Infrastructure_using_Terraform

This Terraform project provisions a full production-grade AWS environment designed for a scalable web application. It automates the setup of networking, compute, storage, security, CI/CD integration, monitoring, and serverless components. The configuration creates a highly available infrastructure built around best practices for reliability, security, and automation.

## Key Components

### 1. Networking (VPC + Subnets + Routing)

Creates a dedicated VPC (172.16.0.0/16)

Provisions three public subnets across different Availability Zones

Configures an Internet Gateway and route table for outbound internet access

Associates each subnet with the route table

### 2. Security Groups

Application SG: Allows ALB traffic to EC2 instances on port 3002

Database SG: Allows MySQL access (3306) from application instances

ALB SG: Allows inbound HTTPS (443)

### 3. Application Load Balancer (ALB)

Internet-facing ALB

HTTPS listener configured with ACM certificate

Target group with health checks and cookie-based stickiness

Integrated with Auto Scaling Group

### 4. Compute Layer (EC2 + Auto Scaling)

Launch configuration for app instances with:

User-data providing environment variables (DB host, S3 bucket, etc.)

IAM instance profile for S3/RDS/SNS access

Auto Scaling Group with:

Min: 2, Max: 5 instances

CPU-based CloudWatch scaling policies (scale up/down)

ASG attached to the ALB target group

### 5. Database Layer (RDS)

MySQL 8.0 RDS instance

Encrypted storage

Private subnets (via DB subnet group)

Parameter group enabling performance schema

### 6. Storage (S3 Buckets)

Creates and configures:

Webapp bucket

CodeDeploy artifacts bucket

Lambda code bucket

All include:

Private access

Server-side encryption (AES-256)

Lifecycle rules for cost optimization

### 7. CI/CD Integration (CodeDeploy + IAM for CircleCI)

CodeDeploy application + deployment group

Integration with Auto Scaling Group + ALB

Full IAM policy set for a CircleCI user:

Upload artifacts to S3

Trigger CodeDeploy deployments

Manage Lambda functions

### 8. IAM Roles & Permissions

EC2 role with access to:

S3 buckets

CloudWatch agent

Autoscaling operations

SNS publish actions

CodeDeploy service role

Lambda execution role with S3, DynamoDB, SES, and Lambda permissions

### 9. Logging & Monitoring

CloudWatch log group and streams for application logs

High/Low CPU CloudWatch alarms connected to Auto Scaling policies

### 10. Serverless (Lambda)

Lambda function for password reset workflow

Packaged from passwordReset.zip

SNS topic triggers Lambda execution

Role permissions for S3, SES, DynamoDB, and Lambda API calls

### 11. Messaging & Email (SNS, SES, SQS)

SNS topic for password reset

SES bounce/complaint handling:

SQS queues

SNS topics

IAM queue policies for secure message publishing

### 12. DNS (Route 53)

A-record for the domain pointing to ALB via alias

## Purpose

This Terraform project delivers an end-to-end AWS environment suitable for hosting a production web application with:

  Scalable compute resources
  
  Reliable database backend
  
  Automated deployments
  
  Secure networking
  
  Monitoring, logging, and alerting
  
  Serverless support for email and background workflows
