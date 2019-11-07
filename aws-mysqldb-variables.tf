variable "ec2-count" {
  default = "1"
}
variable "ami-id" {
  default = "ami-07b4f3c02c7f83d59"
}
variable "instance-type" {
  default = "t2.micro"
}
#variable "subnet-id" {
#       default="${subnet_id}"
#}
variable "aws-region" {
  default = "us-west-2a"
}

#variable "instance-tag" {
#  type    = list
#  default = ["mysql-db-1", "mysql-db-2", "mysql-db-3", "mysql-db-4"]
#}
