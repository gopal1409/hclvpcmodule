data "aws_availability_zones" "my_azones" {
  filter {
    name = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_instance" "ec2demo"{

    ami = data.aws_ami.amznlinux2.id
    instance_type = var.instance_type
    user_data = file("${path.module}/app1-install.sh")
    key_name = var.instance_keypair
    vpc_security_group_ids = [aws_security_group.vpc-ssh1.id,aws_security_group.vpc-web1.id]
    #it will create ec2 instance in all the avaiability zones of a vpc
    for_each = toset(data.aws_availability_zones.my_azones.names)
    availability_zone = each.key
    subnet_id = module.vpc.public_subnet[0]
      
    tags = {
    Name = "for_each-demo-${each.value}"
  }
}