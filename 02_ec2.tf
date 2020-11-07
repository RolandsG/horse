# Create AWS Instace
resource "aws_instance" "horse_ec2" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.horse_subnet_public.id
  key_name = var.key_name
  user_data = file("install_resources.sh")
  vpc_security_group_ids = [aws_security_group.horse_sg.id]
  iam_instance_profile = aws_iam_instance_profile.s3_access_profile.name

  tags = {
    Name = "${var.Module_name}.${var.aws_region}"
  }
}