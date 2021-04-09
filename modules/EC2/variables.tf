variable "ec2_count" {
    type = number
}
variable "amis" {
    type = string
}
variable "vpc_id" {
    type = string
}
variable "instance_type" {
    type = string
}
variable "subnet_ids" {
    type = list(string)
}
variable "security_group_id" {
    type = string
}
variable "key_name" {
  type = string
}
variable "ec2_name" {
  type = string
}