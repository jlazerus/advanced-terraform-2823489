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
resource "aws_cloud9_environment_ec2" "cloud9env1" {
  instance_type = "t2.micro"
  name          = "MythicalMysfitsIDE"
  description = "This IDE will be used to create the Mythical Mysfits website as part of an AWS tutorial"
  owner_arn = var.owner_arn
  automatic_stop_time_minutes = 30
}

resource "aws_sns_topic" "user_updates" {
  name = "user-updates-topic"
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "SysOpsBook"

  dashboard_body = <<EOF
{
    "widgets": [
        {
            "type": "metric",
            "x": 0,
            "y": 6,
            "width": 6,
            "height": 9,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/EC2", "CPUUtilization" ]
                ],
                "region": "us-east-2"
            }
        },
        {
            "type": "metric",
            "x": 6,
            "y": 6,
            "width": 6,
            "height": 9,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/S3", "NumberOfObjects", "StorageType", "AllStorageTypes", "BucketName", "aws-cloudtrail-logs-588974386822-91669ce4", { "period": 86400 } ],
                    [ ".", "BucketSizeBytes", ".", "StandardStorage", ".", ".", { "period": 86400 } ],
                    [ ".", "NumberOfObjects", ".", "AllStorageTypes", ".", "jlazerus-workshop", { "period": 86400 } ],
                    [ ".", "BucketSizeBytes", ".", "StandardStorage", ".", ".", { "period": 86400 } ]
                ],
                "region": "us-east-2"
            }
        },
        {
            "type": "text",
            "x": 0,
            "y": 0,
            "width": 12,
            "height": 6,
            "properties": {
                "markdown": "\n# Existing S3 and EC2 stuff\n## Sub-heading\nYo\nA [link](https://amazon.com). A link to this dashboard: [SysOpsBook](#dashboards:name=SysOpsBook).\n\n[button:Button link](https://amazon.com) [button:primary:Primary button link](https://amazon.com)\n\nTable | Header\n----|-----\nCloudWatch | Dashboards\n\n```\nText block\nssh my-host\n```\nList syntax:\n\n* CloudWatch\n* Dashboards\n  1. Graphs\n  1. Text widget\n"
            }
        }
    ]
}
EOF
}
