variable "aws_access_key" {
  description = "my aws access key"
  type        = string
}

variable "aws_secret_key" {
  description = "my aws secret key"
  type        = string
}

variable "region" {
  description = "aws region where all resources will be created"
  type        = string
  default     = "ap-southeast-1"
}
