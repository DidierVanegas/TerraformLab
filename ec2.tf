#EC2 Instances:
resource "aws_instance" "instance" {
  count           = length(aws_subnet.public_subnet.*.id)
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = element(aws_subnet.public_subnet.*.id, count.index)
  security_groups = [aws_security_group.sg.id, ]
  key_name        = "Keypair01"
  #iam_instance_profile = data.aws_iam_role.iam_role.name


  user_data = file("./userdata.sh")

  tags = {
    "Name"        = "Crash_Server_${count.index}"
    "Environment" = "Test"
    "CreatedBy"   = "Didier Vanegas"
  }

  timeouts {
    create = "10m"
  }

}

#Elastic IPs
resource "aws_eip" "eip" {
  count            = length(aws_instance.instance.*.id)
  instance         = element(aws_instance.instance.*.id, count.index)
  public_ipv4_pool = "amazon"
  vpc              = true

  tags = {
    "Name" = "EIP-${count.index}"
  }
}

# EIP association with EC2 Instances:
resource "aws_eip_association" "eip_association" {
  count         = length(aws_eip.eip)
  instance_id   = element(aws_instance.instance.*.id, count.index)
  allocation_id = element(aws_eip.eip.*.id, count.index)
}
