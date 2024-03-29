provider "aws" {
  #access_key = "AKIAYBLNHKCPUCFKNJKL"
  #secret_key = "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"
  region     = "ap-south-1"
}

resource "aws_vpc" "telepathy-vpc" {
  cidr_block       = "${var.vpc-cidr}"
  instance_tenancy = "${var.tenancy}"
  tags = {
    Name = "telepathy-vpc"
  }
}

resource "aws_subnet" "telepathy-subnet" {
  vpc_id            = "${aws_vpc.telepathy-vpc.id}"
  cidr_block        = "${var.subnet-cidr}"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "telepathy-subnet-1"
  }
}

resource "aws_route_table" "telepathy-rt" {
  vpc_id = "${aws_vpc.telepathy-vpc.id}"

  route {
    cidr_block = "${var.route-block}"
    gateway_id = "${aws_internet_gateway.telepathy-igw.id}"
  }
  tags = {
    Name = "telepathy-rt"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.telepathy-subnet.id}"
  route_table_id = "${aws_route_table.telepathy-rt.id}"
}
output "vpc_id" {
  value = "${aws_vpc.telepathy-vpc.id}"
}
output "subnet_id" {
  value = "${aws_subnet.telepathy-subnet.id}"
}

output "instance_private_ip" {
  value = ["${aws_instance.tomcat.*.private_ip}"]
}

output "instance_public_ips" {
  value = ["${aws_instance.tomcat.*.public_ip}"]
}

output "instance_ip_addr" {
  value = aws_instance.tomcat.0.private_ip
}

output "instance_public_ip_addr" {
  value = aws_instance.tomcat.0.public_ip
}

#output "instance_ips" {
#  value = ["${aws_instance.mysqldb.*.public_ip}"]
#}
resource "aws_internet_gateway" "telepathy-igw" {
  depends_on = ["aws_vpc.telepathy-vpc"]
  vpc_id     = "${aws_vpc.telepathy-vpc.id}"

  tags = {
    name = "telepathy-igw"
  }
}
#newcode
resource "aws_security_group" "telepathy-sg" {
 name        = "telepathy-sg"
  #description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.telepathy-vpc.id}"
  

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
   # prefix_list_ids = ["pl-12c4e678"]
  }
}
