resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.subnet_id

  tags = {
    Name = "${var.ngw_name}"
  }
}
resource "aws_eip" "eip" {
  vpc      = true

  tags = {
    Name = "${var.eip_tags}"
  }
}
