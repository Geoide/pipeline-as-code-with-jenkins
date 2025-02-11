// 2 Public Subnets
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.management.id
  cidr_block              = "10.0.${count.index * 2 + 1}.0/24"
  # availability_zone       = element(var.availability_zones, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  count = var.public_subnets_count

  tags = {
    Name   = "public_10.0.${count.index * 2 + 1}.0_${data.aws_availability_zones.available.names[count.index]}"
  }
}

// 2 Private Subnets
resource "aws_subnet" "private_subnets" {
  vpc_id                  = aws_vpc.management.id
  cidr_block              = "10.0.${count.index * 2}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  count = var.private_subnets_count

  tags = {
    Name   = "private_10.0.${count.index * 2}.0_${data.aws_availability_zones.available.names[count.index]}"
  }
}