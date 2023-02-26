resource "aws_vpc" "vpc1" {
  cidr_block       = "10.0.0.0/16"
}

resource "aws_subnet" "subnet1" {
 vpc_id     = aws_vpc.vpc1.id
 cidr_block = "10.0.1.0/24"
}

resource "aws_network_interface" "foo1" {
  subnet_id   = aws_subnet.subnet1.id
  private_ips = ["10.0.1.100"]
}

resource "aws_network_interface" "foo2" {
  subnet_id   = aws_subnet.subnet1.id
  private_ips = ["10.0.1.200"]
}

resource "aws_instance" "instance1" {
  ami = "ami-0bb3fad3c0286ebd5"
  instance_type = "t2.micro"
  key_name = "Online_Retailer"
  tags = {
	Name = "Demo"
  }
  security_groups = sec_group
  network_interface {
    network_interface_id = aws_network_interface.foo1.id
    device_index         = 0
  }
}

resource "aws_instance" "instance2" {
  ami = "ami-0bb3fad3c0286ebd5"
  instance_type = "t2.micro"
  key_name = "Online_Retailer"
  tags = {
	Name = "Demo"
  }
  security_groups = sec_group
  network_interface {
    network_interface_id = aws_network_interface.foo2.id
    device_index         = 0
  }  
}


resource "aws_security_group" "sec_group" {
  name = "sec_group"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = SSH
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = HTTP
    cidr_blocks = ["0.0.0.0/0"]
  }  
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = SSH
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = HTTP
    cidr_blocks = ["0.0.0.0/0"]
  }    
}
