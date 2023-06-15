# Minecraft Server Deployment

This repository contains Terraform configuration files and a shell script to deploy a Minecraft server on AWS using Docker.

## Background

In this tutorial, we will deploy a Minecraft server on AWS using Terraform and Docker. The deployment process involves provisioning an EC2 instance, configuring security groups, and starting the Minecraft server using Docker Compose.

## Requirements

To run the Minecraft server deployment pipeline, you need:

- Terraform: Make sure you have Terraform installed on your machine.
- AWS Account: You'll need an AWS account with appropriate permissions to provision resources.
- AWS CLI: Set up AWS CLI and configure it with your AWS credentials.
- SSH client: You'll need an SSH client to connect to the Minecraft server.

## Diagram

## Setup

1. Clone this repository:

## Cleanup

To stop the server, run the following command:

```
terraform destroy
```
