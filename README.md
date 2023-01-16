# Curotec excersise, build VPC, Database and Kubernetes

This repository contains:

- json templates to build a VPC and a RDS with CloudFormation
- yaml template for build eks cluster with eksctl

## Requirements

- AWS CLI
- eksctl cli
- j2-cli (https://github.com/kolypto/j2cli)

## Setup

- Define the Environment vars:
    AWS_ACCESS_KEY_ID - with the IAM User AWS Access Key ID
	  AWS_SECRET_ACCESS_KEY - with the IAM User Secret Access Key
	  AWS_DEFAULT_REGION - with the AWS Region where the S3 bucket will be created

- in the shell console execute the commands:
		```
		j2 -f json templates/template-vpc.template env/development.json -o vpc.json
		aws cloudformation deploy --stack-name platform-development-vpc --template-file vpc.json --no-fail-on-empty-changeset
		j2 -f json -e ENV templates/template-mariadb.template env/development.json -o mariadb.json
		aws cloudformation deploy --stack-name platform-development-mariadb  --template-file mariadb.json --no-fail-on-empty-changeset
		./eks_build.sh
		```


NOTES:

- the env vars defined and the shell commands indicated must be integrated in the CI/CD pipeline (Github Actions)
