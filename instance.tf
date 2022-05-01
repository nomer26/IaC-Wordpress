data "aws_ami" "ubuntu" {
	most_recent = true

	filter {
		name = "name"
		values =  ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
	}

	owners = ["099720109477"]
}

resource "aws_instance" "webserver" {
	count = 3  											
	ami = data.aws_ami.ubuntu.id
	instance_type = "t2.micro"

	subnet_id = element(aws_subnet.public-web.*.id,count.index)
	vpc_security_group_ids = [aws_security_group.web-sg.id]
	key_name = aws_key_pair.mykeypair.id 

	tags = {
		Name = "public-web-${count.index+1}"
	}
	depends_on = [ aws_db_instance.mysql ]
	provisioner "remote-exec" {
		inline = ["echo 'Wait until SSH is ready'"]

		connection {
			type = "ssh"
			user = "ubuntu"
			host = "${self.public_ip}"
			agent = true
			password = "anwlro55"
		}
	}
	provisioner "local-exec" {
		command = "ansible-playbook -i ${self.public_ip}, --private-key ${var.PATH_TO_PRIVATE_KEY} wordpress.yml"
	}
}


#resource "local_file" "hosts_cfg" {
#	content = template("hosts.tpl",
#		{
#			web_hostname = aws_instance.webserver.*.tags.Name
#			web_ipaddr = aws_instance.webserver.*.public_ip
#			web_private = aws_instance.webserver.*.private_ip
#		})
#		filename = "hosts.cfg"
#}

	
