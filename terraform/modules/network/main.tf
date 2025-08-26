resource "aws_subnet" "private" {
  for_each                = var.private_subnets
  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az_name
  tags = {
    Name = "${var.project_name}-${var.environment}-private-subnet-${each.key}"
  }
}

resource "aws_subnet" "public" {
  for_each                = var.public_subnets
  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az_name
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.environment}-public-subnet-${each.key}"
  }
}

# 라우팅 테이블
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.aws_internet_gateway_id
  }
  tags = {
    Name = "${var.project_name}-${var.environment}-public-rt"
  }
}

resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.project_name}-${var.environment}-private-rt-${each.key}"
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}

resource "aws_route" "s3_endpoint_route" {
  # count                  = length(aws_route_table.private)
  for_each = aws_route_table.private
  route_table_id              = each.value.id
  destination_prefix_list_id  = var.prefix_list_id
  vpc_endpoint_id             = var.s3_gateway_id
}
