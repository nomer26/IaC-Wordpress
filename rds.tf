resource "aws_db_subnet_group" "mysql-subnet" {
	name = "mysql-subnet"
	description = "RDS subnet group"
	subnet_ids = flatten(["${aws_subnet.private-web.*.id}"])
}

resource "aws_db_parameter_group" "mysql-parameters" {
	name = "mysql-parameters"
	family = "mysql5.7"
	description = "Mysql parameter group"

	parameter {
		name = "character_set_server"
		value = "utf8"
	}
	parameter {
		name = "character_set_client"
		value = "utf8"
	}
}

resource "aws_db_instance" "mysql" {
	allocated_storage = 20
	engine = "mysql"
	engine_version = "5.7"
	instance_class = "db.t2.micro"
	identifier = "mysql"
	db_name = "wordpress1"
	username = "test"
	password = var.RDS_PASSWORD
	vpc_security_group_ids = [ aws_security_group.mysql-sg.id ]
	db_subnet_group_name = aws_db_subnet_group.mysql-subnet.name
	parameter_group_name = aws_db_parameter_group.mysql-parameters.name
	multi_az = "false"
	storage_type = "gp2"
	availability_zone = element(aws_subnet.private-web.*.availability_zone,0)
	skip_final_snapshot = true
	tags = {
		Name = "mysql-instance"
	}
}

output "endpoint" {
	value = aws_db_instance.mysql.endpoint
}

resource "local_file" "endpoint" {
	content = templatefile("wp-config.tpl",
		{
			db_host = aws_db_instance.mysql.endpoint
		})
	filename = "roles/wordpress/templates/wp-config.j2"
}
