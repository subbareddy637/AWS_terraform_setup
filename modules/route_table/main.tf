resource "aws_route_table" "public_route_table" {
  count = var.public_route_table ? 1 : 0
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${var.public_rt_name}"
  }
}
resource "aws_route_table_association" "public_route_table_association" {
  
  count          = length(var.subnet_cidr) > 0 && var.public_route_table ? length(var.subnet_cidr) : 0
  subnet_id      = element(var.subnets, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  count = var.public_route_table ? 1 : 0
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "${var.private_rt_name}"
  }
}
resource "aws_route_table_association" "private_route_table_association" {
  
  count          = length(var.subnet_cidr) > 0 && var.public_route_table ? length(var.subnet_cidr) : 0
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.private_route_table.id
}