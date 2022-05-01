variable "AWS_REGION" {
	default = "ap-northeast-2"
}

variable "PATH_TO_PRIVATE_KEY" {
	default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
	default = "mykey.pub"
}

variable "RDS_PASSWORD" {
	default = "password"
}

variable "AZS" {
	default = ["ap-northeast-2a","ap-northeast-2c"]
}
