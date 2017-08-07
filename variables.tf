variable "key_name" {}

variable "instype" {
  default = "t2.micro"
}


variable "path_to_file" {
  default = "./kibana.sh"
}

variable "subnet_id" {
  type = "list"
}

variable "vpc_id" {}

variable "puppet_ip" {}
variable "dns_name" {}
variable "vpc_netprefix" {
    default = "10.231"
}
variable "pub_sn_netnumber" {
    default = "23"
}
variable "number_of_azs"{
    default = 1
}
variable "priv_sn_netnumber" {}
variable "priv_sn_netmask" {}
variable "pub_sn_netmask"{}
