variable "vpc-cidr" {
  default = "10.0.0.0/16"
}
variable "tenancy" {
  default = "default"
}
#variable "vpc-id" {}
variable "subnet-cidr" {
  default = "10.0.2.0/24"
}
variable "route-block" {
  default = "0.0.0.0/0"
}
#variable "security-groupid" {
 # default = "sg-04d8b0915426482ed"
 # }
