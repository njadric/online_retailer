resource "aws_security_group" "http-sg" {
  name        = "allow_http_access"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }
  tags = {
    "Name" = "Application-1-sg"
  }
}
resource "aws_instance" "app-server1" {
  instance_type                 = "t2.micro"
  ami                           = "ami-0bb3fad3c0286ebd5"
  vpc_security_group_ids        = [aws_security_group.http-sg.id]
  subnet_id                     = aws_subnet.private-2a.id
  associate_public_ip_address   = true
  user_data = file("user_data/user_data.tpl")
  tags = {
    Name = "app-server-1"
  }
}
resource "aws_instance" "app-server2" {
  instance_type                 = "t2.micro"
  ami                           = "ami-0bb3fad3c0286ebd5"
  vpc_security_group_ids        = [aws_security_group.http-sg.id]
  subnet_id                     = aws_subnet.private-2b.id
  associate_public_ip_address   = true
  user_data                     = file("user_data/user_data.tpl")
  tags = {
    Name = "app-server-2"
  }
}
resource "aws_instance" "app-server3" {
  instance_type                 = "t2.micro"
  ami                           = "ami-0bb3fad3c0286ebd5"
  vpc_security_group_ids        = [aws_security_group.http-sg.id]
  subnet_id                     = aws_subnet.private-2c.id
  associate_public_ip_address   = true
  user_data                     = file("user_data/user_data.tpl")
  tags = {
    Name = "app-server-3"
  }
}