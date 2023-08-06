# vpc Id

output "vpc_id" {
  value = aws_vpc.prod_vpc.id
  description = "id of the vpc"
}

# subnet Id

output "subnet_id_1" {
  value = aws_subnet.prod_pubsub_1.id
  description = "subnet id"
}

output "subnet_id_2" {
  value = aws_subnet.prod_pubsub_2.id
  description = "subnet id"
}

output "subnet_id_3" {
  value = aws_subnet.prod_ptesub_1.id
  description = "subnet id"
}

output "subnet_id_4" {
  value = aws_subnet.prod_ptesub_2.id
  description = "subnet id"
}