provider "aws" {
    region = "us-east-1"

    # shared_credentials_file = "c:/temp/creds"
}

resource "aws_instance" "test-vm" {
    ami = "ami-0998c31db74342579"
    instance_type = "t1.micro"
}