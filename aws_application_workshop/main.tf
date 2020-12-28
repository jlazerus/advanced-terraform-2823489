# https://github.com/aws-samples/aws-modern-application-workshop/tree/python-cdk/module-1
# //////////////////////////////
# VARIABLES
# //////////////////////////////
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "region" {
  default = "us-east-2"
}

variable "owner_arn" {}

# //////////////////////////////
# PROVIDERS
# //////////////////////////////
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}


# //////////////////////////////
# RESOURCES
# //////////////////////////////
resource "aws_cloud9_environment_ec2" "example" {
  instance_type = "t2.micro"
  name          = "MythicalMysfitsIDE"
  description = "This IDE will be used to create the Mythical Mysfits website as part of an AWS tutorial"
  owner_arn = var.owner_arn
  automatic_stop_time_minutes = 30

}
