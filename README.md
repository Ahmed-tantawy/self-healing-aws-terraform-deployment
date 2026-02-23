Self-Healing AWS Deployment with Terraform & Docker
**Overview**

This project demonstrates provisioning AWS infrastructure using Terraform and deploying a containerized Python application to EC2 with automated bootstrap configuration.

**Features**

Infrastructure as Code (Terraform)

EC2 provisioning with security groups

Dockerized Flask application

Multi-architecture image build (ARM64 + AMD64)

Automated container deployment via EC2 user-data

Clean teardown using terraform destroy

**Architecture
**
Local Machine → Docker Buildx → Docker Hub
Terraform → AWS EC2 → Docker → Flask App

Tech Stack

AWS EC2

Terraform

Docker

Python (Flask)

Linux

Git

Key Challenges Solved

ARM (Apple Silicon) vs AMD64 architecture mismatch

EC2 bootstrap debugging using cloud-init logs

Docker service initialization timing issues

**Future Improvements
**
Move to ECS or EKS

Add Load Balancer

Implement CI/CD auto-deployment

Add CloudWatch monitoring and alarms
