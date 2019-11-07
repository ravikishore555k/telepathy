resource "aws_instance" "tomcat" {
  #depends_on = ["aws_internet_gateway.mysqldb-igw"]
  #depends_on                  = ["aws_subnet.telepathy-subnet"]
  count                       = "${var.ec2-count}"
  ami                         = "${var.ami-id}"
  instance_type               = "${var.instance-type}"
  subnet_id                   = "${aws_subnet.telepathy-subnet.id}"
  associate_public_ip_address = "true"
  enable_dns_hostnames = "enable"
  #vpc_security_group_ids = ["sg-04d8b0915426482ed"]
  #vpc_security_group_ids = ["${var.security-groupid}"]
  vpc_security_group_ids = ["${aws_security_group.mysqldbsg.id}"]
  #"sg-04d8b0915426482ed"
  key_name                    = "telepathy-key"
  user_data                   = "${file("install-tomcat.sh")}"
  tags = {
    #    name = "mysql-db-${count.index + 1}"
    name = "tomcat-1"
  }
}
