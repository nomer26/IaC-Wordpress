# internal vpc
resource "aws_vpc" "web" {
	cidr_block = "10.0.0.0/16"
	instance_tenancy = "default"
	enable_dns_support = "true"
	enable_dns_hostnames = "true"
	enable_classiclink = "false"
	tags = {
		Name = "main"
	}
}

# Subnets
resource "aws_subnet" "public-web" {
	count = 2
	vpc_id = aws_vpc.web.id
	cidr_block = "10.0.${count.index+1}.0/24"
	map_public_ip_on_launch = "true"
	availability_zone = element(var.AZS,count.index)

	tags = {
		Name = "public-web${count.index+1}"
	}
}
#resource "aws_subnet" "public-web" {
#	vpc_id = aws_vpc.web.id
#	cidr_block = "10.0.2.0/24"
#	map_public_ip_on_launch = "true"
#	availability_zone = "ap-northeast-2c"
#
#	tags = {
#		Name = "public-web2"
#	}
#}

resource "aws_subnet" "private-web" {
	count = length(var.AZS)
	vpc_id = aws_vpc.web.id
	cidr_block = "10.0.${count.index+3}.0/24"
	map_public_ip_on_launch = "false"
	availability_zone = element(var.AZS,count.index)

	tags = {
		Name = "private-web${count.index+1}"
	}
}
#resource "aws_subnet" "private-web2" {
#	vpc_id = aws_vpc.web.id
#	cidr_block = "10.0.4.0/24"
#	map_public_ip_on_launch = "false"
#	availability_zone = "ap-northeast-2c"
#
#	tags = {
#		Name = "private-web2"
#	}
#}

# Internet GW
resource "aws_internet_gateway" "web-gw" {
	vpc_id = aws_vpc.web.id

	tags = {
		Name = "web-gw"
	}
}

# route tables
resource "aws_route_table" "public-web" {
	vpc_id = aws_vpc.web.id
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.web-gw.id
	}
	tags = {
		Name = "public-web-rt"
	}
}

# route associations public

resource "aws_route_table_association" "public-web" {
	count = 2
	subnet_id = element(aws_subnet.public-web.*.id,count.index)
	route_table_id = aws_route_table.public-web.id
}
#resource "aws_route_table_association" "public-web-c" {
#	subnet_id = aws_subnet.public-web2.id
#	route_table_id = aws_route_table.public-web.id
#}


