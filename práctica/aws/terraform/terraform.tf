terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.34.0"
    }
  }

  required_version = "1.7.1"
}

provider "aws" {
  region = var.region
  profile = var.aws_profile

  default_tags {
    tags = {
      Environment = "${var.resource_tags["environment"]}"
      Project     = "${var.resource_tags["project"]}"
      Author = "${var.resource_tags["author"]}"
    }
  }
}