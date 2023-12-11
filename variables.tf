variable "key_name" {
  description = "AWS key pair name"
  type = string
  default = "aws"
}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "ami" {
  description = "AWS AMI name"
  type        = string
  default     = "ami-042e6fdb154c830c5"
}

variable "instance_type" {
  description = "AWS instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_number" {
  description = "Number of instances"
  type        = number
  default     = 2
}
