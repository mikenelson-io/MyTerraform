# Provision an aws_instance using the AMI created during the Rubrik conversion
resource "aws_instance" "brikcast-demo" {
    count = 1000  
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.large"
    subnet_id = "subnet-0bf323e8d2bccbf50"
    security_groups = ["sg-037dba94215123f6b"]

    tags = {
        Name = "vra-rubrik-16"
    }
}   