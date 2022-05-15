output "vpc_id" {
   value = aws_vpc.main.id
}
output "privatesubnet1_id" {
   value = aws_subnet.privatesubnet1.id
}
output "privatesubnet2_id" {
   value = aws_subnet.privatesubnet2.id
}
output "privatesubnet3_id" {
   value = aws_subnet.privatesubnet3.id
}
output "publicsubnet1_id" {
   value = aws_subnet.publicsubnet1.id
}
output "publicsubnet2_id" {
   value = aws_subnet.publicsubnet2.id
}
output "publicsubnet3_id" {
   value = aws_subnet.publicsubnet3.id
}
output "prefix" {
   value = "${var.prefix}"
}
