provider "aws" {
  #access_key = "AKIAYBLNHKCPUCFKNJKL"
  #secret_key = "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"
  region     = "ap-south-1"
}

resource "aws_vpc" "mysqldbvpc" {
  cidr_block       = "${var.vpc-cidr}"
  instance_tenancy = "${var.tenancy}"
  tags = {
    name = "mysqldbvpc-1"
  }
}

resource "aws_subnet" "mysqldbsubnet" {
  vpc_id            = "${aws_vpc.mysqldbvpc.id}"
  cidr_block        = "${var.subnet-cidr}"
  availability_zone = "ap-south-1"
  tags = {
    name = "mysqldbsubnet-1"
  }
}

resource "aws_route_table" "mysqldbrt" {
  vpc_id = "${aws_vpc.mysqldbvpc.id}"

  route {
    cidr_block = "${var.route-block}"
    gateway_id = "${aws_internet_gateway.mysqldb-igw.id}"
  }
  tags = {
    name = "mysqldbrt"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.mysqldbsubnet.id}"
  route_table_id = "${aws_route_table.mysqldbrt.id}"
}
output "vpc_id" {
  value = "${aws_vpc.mysqldbvpc.id}"
}
output "subnet_id" {
  value = "${aws_subnet.mysqldbsubnet.id}"
}
#output "instance_ips" {
#  value = ["${aws_instance.mysqldb.*.public_ip}"]
#}
resource "aws_internet_gateway" "mysqldb-igw" {
  depends_on = ["aws_vpc.mysqldbvpc"]
  vpc_id     = "${aws_vpc.mysqldbvpc.id}"

  tags = {
    name = "mysqldb-igw"
  }
}
#newcode
resource "aws_security_group" "mysqldbsg" {
 name        = "mysqldbsg"
  #description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.mysqldbvpc.id}"
  

  ingress {
    
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = ["pl-12c4e678"]
  }
}
