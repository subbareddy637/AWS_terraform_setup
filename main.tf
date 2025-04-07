module "vpc" {
  source = "../modules/vpc"

  vpc_cidr = ["10.0.0.0/16"]
  tags = {
    Name = "vpc"
  }
}

module "public_subnets" {
  source = "../modules/Subnets"

  subnet_cidr = ["10.0.1.0/24"]
  vpc_id = module.vpc.vpc.id
  availability_zone = ["us-east-1a"]
  map_public_ip_on_launch = false
  subnet_name = "public"

  depends_on = [module.vpc]
}

module "private_subnets" {
  source = "../modules/Subnets"

  subnet_cidr = ["10.0.5.0/24"]
  vpc_id = module.vpc.vpc.id
  availability_zone = ["us-east-1b"]
  map_public_ip_on_launch = false
  subnet_name = "private"

  depends_on = [module.vpc]
}

module "security_group" {
  source = "../modules/Security_groups"

  name = "sg-1"
  description = ""
  vpc_id = module.vpc.vpc.id

  sg_ingress = [
    {
      from_port = 80
      protocol = "tcp"
      to_port = 80
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow web traffic to load balancer"
    },
    {
      from_port   = 8080
      protocol    = "tcp"
      to_port     = 9080
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow web traffic to load balancer"
    },
    {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
    }
  ]
  sg_egress = [
    {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

}


module "internet_gateway" {
  source = "../modules/internet_gateway"

  vpc_id = module.vpc.vpc.id

}
/*
module "nat_gateway" {
  source = "./modules/nat_gateway"

  subnet_id = module.public_subnets.subnet[0].id
  ngw_name= "nat_gw"
  eip_tags = "eip"
}

module "public_route_table" {
  source = "../modules/route_table"


  vpc_id = module.vpc.vpc_id
  igw_id = module.internet_gateway.igw.id
  subnet_cidr = ["10.0.1.0/24"]
  subnets = module.public_subnet.subnet.*.id
  public_route_table = "true"
  public_rt_name = "public_route_table"
}

module "private_route_table" {
  source = "../modules/route_table"


  vpc_id = module.vpc.vpc_id
  igw_id = module.nat_gateway.nat_gw.id
  subnet_cidr = ["10.0.5.0/24"]
  subnets = module.private_subnet.subnet.*.id
  public_route_table = "true"
  private_rt_name = "private_route_table"

}

module "lb_target_group" {
  source = "../modules/target_groups"

  name = "lb_target_group"
  vpc_id = module.vpc.vpc.id
  target_group_port = "8081"
  health_check_port = "Traffic port"

}
 
module "load_balancer" {
  source = "../modules/load_balancer"

  name = "alb"
  load_balancer_type = "application"
  security_group = module.security_group.security_group.id
  subnets = module.public_subnets.subnet.*.id
  enable_deletion_protection = true
  load_balancer_arn = module.load_balancer.load_balancer_arn
  listener_port = 80
  target_group_arn = module.lb_target_group.lb_tg.arn

}
*/
module "key_pair" {
  source = "../modules/key_pair"

  name = ""
}

module "ec2_server" {
  source = "../modules/EC2"

  ec2_count = 1
  ami = ami-0742b4e673072066f
  instancd_type = t2.micro
  vpc_id = module.vpc.vpc.id
  security_group = module.security_group.sg.id 
  subnet_ids = module.public_subnet.*.id 
  key_name = module.key_name.private_key_name
  ec2_name = ec2-instance

}
/*
module "auto_scaling_group" {
  source = "../modules/autoscaling_group"

  name = lc
  ami = ami-0742b4e673072066f
  instance_type = t2.micro
  security_group_id = module.security_group.sg.id 
  associate_public_ip_address = false
  key_name = module.key_name.private_key_name
  device_name = "/dev/sdh"
  volume_type = gp2
  volume_size = 40
  volume_iops = 0

  asg_name = "asg"
  max_size = "3"
  min_size = "1"
  health_check_type= "ELB"
  desired_capacity = "1"
  subnet_ids = module.public_subnet.subnet.*.id
  target_group_arn = module.lb_target_group.target_group.target_group_arn

  tags = [
    map("Name", "asg")
  ]
}
*/
