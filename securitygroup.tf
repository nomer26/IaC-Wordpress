resource "aws_security_group" "mysql-sg" {
	name = "allow-mysql"
	vpc_id = aws_vpc.web.id
	description = "security group that allows mysql and all egress traffic"
	
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port = 3306
		to_port = 3306
		protocol = "tcp"
		cidr_blocks = ["10.0.0.0/16"]
	}
	tags = {
		Name = "allow-mysql"
	}
}
resource "aws_security_group" "web-sg" {
	name = "allow-ssh-http"
	vpc_id = aws_vpc.web.id
	description = "security group that allows ssh,http and all egress traffic"

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		description = "http"
	}
	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		description = "ssh"
	}
	ingress {
		from_port = 3306
		to_port = 3306
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		description = "mysql"
	}
	tags = {
		Name = "allow-ssh-http"
	}
}
