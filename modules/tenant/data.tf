data "aws_ami" "windows_server" {
  most_recent = true

  owners = ["801119661308"] # Amazon official Windows AMIs

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}