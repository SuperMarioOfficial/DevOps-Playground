### Deploy an AWS instance with packer 
- Download the .pem file from ```EC2 > Key pairs```
- Retrieve aws_access_key and aws_secret_key from "Your Security Credentials"
- The ami source is bound to the region ```ami-0596aab74a1ce3983``` will be different in NA
- When the packer script it end will terminate the instance (terminate means deleting), you can retrieve and lounch a new instance of that image under image > ami. 
- when ssh into your machine you need to change the ssh from root to ```"ssh_username": "ec2-user",```
```
{
  "variables": {
    "aws_access_key": "",
    "aws_secret_key": "",
    "aws_region": "eu-west-2",
    "source_ami": "ami-0596aab74a1ce3983",
    "instance_type": "t2.micro"
  },
  "builders": [
    {
      "type": "amazon-ebs",
      "access_key": "{{user `aws_access_key`}}",
      "secret_key": "{{user `aws_secret_key`}}",
      "region": "{{ user `aws_region` }}",
      "associate_public_ip_address": true,
      "source_ami": "{{user `source_ami`}}",
      "instance_type": "{{user `instance_type`}}",
      "ssh_username": "ec2-user",
      "ssh_keypair_name": "EUW",
      "ssh_private_key_file": "EUW.pem",
      "disable_stop_instance": "false",
      "shutdown_behavior": "stop",
      "ami_name": "packer-{{timestamp}}",
      "ami_description": "test_description",
      "tags": {
        "Name": "t2.micro-ami-{{isotime}}",
        "OS_Version": "Amazon Linux",
        "Release": "{{isotime}}",
        "Runner": "EC2"
      }
    }],
       "provisioners": [
        {
          "type": "shell",
          "inline": [
            "sudo pip install ansible==2.7.9"
          ]
        }
      ]
}


```

### Connect with [SSH](https://github.com/SuperMarioOfficial/SSH)
![](https://raw.githubusercontent.com/SuperMarioOfficial/Build-your-own-vagrant.box/master/tutorials/data/2.PNG)

