output "for_output_list" {
    description = "public ip of instance"
    value = [for instance in aws_instance.ec2demo: instance.public_dns] 
}