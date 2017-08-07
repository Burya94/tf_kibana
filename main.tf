data "aws_ami" "centos7" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-7.3_HVM-20170613-x86_64*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


data "template_file" "kibana" {
  template = "${file("${path.module}/${var.path_to_file}")}"

  vars {
    puppet_ip = "${var.puppet_ip}"
    dns_name = "${var.dns_name}"
  }
}

resource "aws_instance" "kibana" {
  count           = "${var.number_of_azs}"
  key_name        = "${var.key_name}"
  ami             = "${data.aws_ami.centos7.id}"
  instance_type   = "${var.instype}"
  user_data       = "${data.template_file.kibana.rendered}"
  subnet_id       = "${element(var.subnet_id, count.index)}"
  security_groups = ["${aws_security_group.kibana.id}"]
  depends_on      = ["aws_security_group.kibana"]

  tags {
    Name = "${count.index}.kibana"
  }
}

resource "aws_security_group" "kibana" {
    name   = "${count.index}kibana"
    vpc_id = "${var.vpc_id}"
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      from_port    = 8140
      to_port      = 8140
      protocol     = "tcp"
      cidr_blocks   = ["${var.vpc_netprefix}.${var.priv_sn_netnumber}${count.index}.0/${var.priv_sn_netmask}"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 9200
        to_port     = 9200
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_netprefix}.${var.pub_sn_netnumber}${count.index}.0/${var.pub_sn_netmask}"]
    }

    ingress {
        from_port   = 5601
        to_port     = 5601
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "${count.index}kibana"
    }
}
