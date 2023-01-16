#!/bin/sh

export VPC_ID=`aws cloudformation describe-stacks --stack-name platform-development-vpc --query "Stacks[].Outputs[0].OutputValue" --output text`
export SUBNET_PRIV_A_ID=`aws cloudformation describe-stacks --stack-name platform-development-vpc --query "Stacks[].Outputs[?OutputKey=='SubnetPrivateAId'].OutputValue" --output text`
export SUBNET_PRIV_B_ID=`aws cloudformation describe-stacks --stack-name platform-development-vpc --query "Stacks[].Outputs[?OutputKey=='SubnetPrivateBId'].OutputValue" --output text`
export SUBNET_PRIV_C_ID=`aws cloudformation describe-stacks --stack-name platform-development-vpc --query "Stacks[].Outputs[?OutputKey=='SubnetPrivateCId'].OutputValue" --output text`
export SUBNET_PUB_A_ID=`aws cloudformation describe-stacks --stack-name platform-development-vpc --query "Stacks[].Outputs[?OutputKey=='SubnetPublicAId'].OutputValue" --output text`
export SUBNET_PUB_B_ID=`aws cloudformation describe-stacks --stack-name platform-development-vpc --query "Stacks[].Outputs[?OutputKey=='SubnetPublicBId'].OutputValue" --output text`
export SUBNET_PUB_C_ID=`aws cloudformation describe-stacks --stack-name platform-development-vpc --query "Stacks[].Outputs[?OutputKey=='SubnetPublicCId'].OutputValue" --output text`
j2 -f json -e ENV templates/eksctl.template env/development.json -o eksctl.yaml
eksctl upgrade cluster -f eksctl.yaml || eksctl create cluster -f eksctl.yaml
