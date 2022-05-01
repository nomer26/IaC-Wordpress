# nat gw
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.public-web.*.id,0)
  depends_on    = [aws_internet_gateway.web-gw, aws_eip.nat]
}

# VPC setup for NAT
resource "aws_route_table" "web-private" {
  vpc_id = aws_vpc.web.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "web-private"
  }
}

# route associations private
resource "aws_route_table_association" "web-private" {
	count = 2
  subnet_id      = element(aws_subnet.private-web.*.id,count.index)
  route_table_id = aws_route_table.web-private.id
}
#resource "aws_route_table_association" "web-private-c" {
#  subnet_id      = aws_subnet.private-web2.id
#  route_table_id = aws_route_table.web-private.id
#}
