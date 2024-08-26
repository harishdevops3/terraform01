resource "aws_instance" "harish" {
  count         = var.no_of_instance
  ami           = ("ami-0e86e20dae9224db8")
  instance_type = var.instance_type
  key_name      = aws_key_pair.harish.key_name

  root_block_device {
    volume_size = 30
  }

  subnet_id                   = aws_subnet.public_subnet[count.index].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.harish_sg.id]

}

resource "aws_key_pair" "harish" {
  key_name   = "harish-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3PnTTZhsyOeVigBuxp+Jn6Pvdr+MBWx2ArN8zY8CNYf0tqyvHGKuTMHb/4i8li0bYQo56XjURZNLLvZvEVg0qm/3SBG0WFHt8923HtN7LFGG+xhJBogMTw1PZNzi1oD3jVkJzVkVJ8pAJnyZY1YeNhTpFfuGeQ7R7JzMkL3VksDanbEVNtUQduATN6xzbuCz7yuYBLpeYuDSXd1mm5fc5UYg+JF7CWtkoS1o7d5o8ArQL+F8y6MatywWeO6Esrr6I8T/8ebVvVDiXkqvAVsLEH0fHdfhcTpYbowEUDCbYspWtJjtxPbN0WeUciGLH4tdCWryO15Bn/nNWH1LyOFd3U8FMbv4V7OLE5TYKiRsZmAM1FdoZGrG+idSjhRT7cWFupR7Y0rj+9/CA4SStxvbQA1+fU78DRaLnW4dFpsreVwTia/czFxxe1HKw6mJMNEdaL+pLZRHs7DOg6k1r8JCTP6gp4tJ+lhE2w9haa4gGoTiG1x1Y2V+tDZh4G7LH2SfkpW9o+qqp9X5HIauJAeAAS9Juj/IZ77oaOtDL+3YJmlzQnkVJaJH4FuCu1sPz7n55M/lW/QXMaahHrJTuMOY5qlR/2EiuoSAd4j9Pdd0k4B1ckJ8yaFXphWTKKgAS3/jyudC0HGQDDbK6vzOF95FTr3/3BWzT5Ou+JiP2priDfw== harish1-ec2-key"
}