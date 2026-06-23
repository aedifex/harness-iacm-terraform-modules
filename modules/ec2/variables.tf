variable "instance_type" {
  type = string
  # default = "t3.micro"
  default = "t3.medium"
}

variable "name" {
  type    = string
  default = "terraform-web"
}

variable "key_name" {
  type    = string
  default = "aws-iac-lab-usw2-ssh"
}