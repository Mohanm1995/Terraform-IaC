### VPC

resource "aws_vpc" "my_vpc" {
   cidr_block = "10.0.0.0/16"
   enable_dns_support = true            
   enable_dns_hostnames = true          

   tags = {
      Name = "my-vpc"
   }
}

### public subnet 1

resource "aws_subnet" "public_subnet_1" {
   vpc_id = aws_vpc.my_vpc.id
   cidr_block = "10.0.1.0/24"
   availability_zone = "ap-south-1a"   
   map_public_ip_on_launch = true      

   tags = {
      Name = "public-subnet-1"
   }
}

### public subnet 2

resource "aws_subnet" "public_subnet_2" {
   vpc_id = aws_vpc.my_vpc.id
   cidr_block = "10.0.2.0/24"
   availability_zone = "ap-south-1b"   
   map_public_ip_on_launch = true      

   tags = {
      Name = "public-subnet-2"
   }
}

### private subnet 1

resource "aws_subnet" "private_subnet_1" {
   vpc_id = aws_vpc.my_vpc.id
   cidr_block = "10.0.3.0/24"
   availability_zone = "ap-south-1a"   

   tags = {
      Name = "private-subnet-1"
   }
}

### private subnet 2

resource "aws_subnet" "private_subnet_2" {
   vpc_id = aws_vpc.my_vpc.id
   cidr_block = "10.0.4.0/24"
   availability_zone = "ap-south-1b"   

   tags = {
      Name = "private-subnet-2"
   }
}

### private subnet 3

resource "aws_subnet" "private_subnet_3" {
   vpc_id = aws_vpc.my_vpc.id
   cidr_block = "10.0.5.0/24"
   availability_zone = "ap-south-1a"   

   tags = {
      Name = "private-subnet-3"
   }
}

### private subnet 4

resource "aws_subnet" "private_subnet_4" {
   vpc_id = aws_vpc.my_vpc.id
   cidr_block = "10.0.6.0/24"
   availability_zone = "ap-south-1b"   

   tags = {
      Name = "private-subnet-4"
   }
}

### private subnet 5

resource "aws_subnet" "private_subnet_5" {
   vpc_id = aws_vpc.my_vpc.id
   cidr_block = "10.0.7.0/24"
   availability_zone = "ap-south-1a"   

   tags = {
      Name = "private-subnet-5"
   }
}

### private subnet 6

resource "aws_subnet" "private_subnet_6" {
   vpc_id = aws_vpc.my_vpc.id
   cidr_block = "10.0.8.0/24"
   availability_zone = "ap-south-1b"   

   tags = {
      Name = "private-subnet-6"
   }
}

### internet gateway

resource "aws_internet_gateway" "my_igw" {
   vpc_id = aws_vpc.my_vpc.id

   tags = {
      Name = "my-igw"
   }
}

### elastic ip

resource "aws_eip" "nat_eip" {          
   domain = "vpc"                       

   tags = {
      Name = "nat-eip"
   }
}

### nat gateway

resource "aws_nat_gateway" "my_nat_gateway" {   
   allocation_id = aws_eip.nat_eip.id           
   subnet_id = aws_subnet.public_subnet_1.id    

   tags = {
      Name = "my-nat-gateway"
   }
}

### public route table

resource "aws_route_table" "public_rt_1" {
   vpc_id = aws_vpc.my_vpc.id

   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.my_igw.id
   }

   tags = {
      Name = "public-rt-1"
   }
}

### private route table 1

resource "aws_route_table" "private_rt_1" {
   vpc_id = aws_vpc.my_vpc.id

   route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.my_nat_gateway.id   
   }

   tags = {
      Name = "private-rt-1"
   }
}

### private route table 2

resource "aws_route_table" "private_rt_2" {
   vpc_id = aws_vpc.my_vpc.id

   tags = {
      Name = "private-rt-2"
   }
}

### private route table 3

resource "aws_route_table" "private_rt_3" {
   vpc_id = aws_vpc.my_vpc.id

   route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.my_nat_gateway.id   
   }

   tags = {
      Name = "private-rt-3"
   }
}

### public subnet association

resource "aws_route_table_association" "public_subnet_1_association" {
   subnet_id = aws_subnet.public_subnet_1.id
   route_table_id = aws_route_table.public_rt_1.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
   subnet_id = aws_subnet.public_subnet_2.id
   route_table_id = aws_route_table.public_rt_1.id
}

### private subnet association

resource "aws_route_table_association" "private_subnet_1_association" {
   subnet_id = aws_subnet.private_subnet_1.id
   route_table_id = aws_route_table.private_rt_1.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
   subnet_id = aws_subnet.private_subnet_2.id
   route_table_id = aws_route_table.private_rt_1.id
}

resource "aws_route_table_association" "private_subnet_3_association" {
   subnet_id = aws_subnet.private_subnet_3.id
   route_table_id = aws_route_table.private_rt_2.id
}

resource "aws_route_table_association" "private_subnet_4_association" {
   subnet_id = aws_subnet.private_subnet_4.id
   route_table_id = aws_route_table.private_rt_2.id
}

resource "aws_route_table_association" "private_subnet_5_association" {
   subnet_id = aws_subnet.private_subnet_5.id
   route_table_id = aws_route_table.private_rt_3.id
}

resource "aws_route_table_association" "private_subnet_6_association" {
   subnet_id = aws_subnet.private_subnet_6.id
   route_table_id = aws_route_table.private_rt_3.id
}

### Security group

resource "aws_security_group" "nginx_sg" {
   vpc_id = aws_vpc.my_vpc.id

### inbound rule

   ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }

   ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }

### outbound rule

   egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
      Name = "nginx-sg"
   }
}

### EC2 instance

resource "aws_instance" "nginx_server" {
   ami = "ami-009be0edec0817ffd"                                   # Change based on region
   instance_type = "t3.micro"                                      # Modify as needed
   subnet_id = aws_subnet.public_subnet_1.id
   vpc_security_group_ids = [aws_security_group.nginx_sg.id]
   associate_public_ip_address = true

   user_data = <<-EOF
               #!/bin/bash
               yum update -y                 
               yum install nginx -y
               systemctl start nginx
               systemctl enable nginx        
               EOF

   tags = {
      Name = "nginx-server"
   }
}
