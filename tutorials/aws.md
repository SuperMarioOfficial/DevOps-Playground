### Deploy an AWS instance with packer 
```
{
  "variables": {
    "aws_access_key": "----------------",
    "aws_secret_key": "----------------",
    "aws_region":"eu-west-2",
    "source_ami": "ami-0596aab74a1ce3983",
    "instance_type": "t2.micro"
  },
"builders": [{
"type": "amazon-ebs",
"access_key": "{{user `aws_access_key`}}",
"secret_key": "{{user `aws_secret_key`}}",
"region": "{{ user `aws_region` }}",
"associate_public_ip_address": true,
"source_ami": "{{user `source_ami`}}",
"instance_type": "{{user `instance_type`}}",
"ssh_username":"ec2-user",
"ssh_keypair_name":"EUW",
"ssh_private_key_file":"EUW.pem",
 "ami_name": "packerNew-{{timestamp}}",
     "ami_description": "test_description", 
     "tags": {
       "role": "test_role"
     },
     "run_tags": {
       "role": "test_tag"
     }
 }], 

 "provisioners": [{
      "type": "shell",
      "inline": [
        "sudo yum update -y && sudo yum install ansible  -y "
      ]
    }
]
}
```

### Connect with [SSH](https://github.com/SuperMarioOfficial/SSH)
![](https://raw.githubusercontent.com/SuperMarioOfficial/Build-your-own-vagrant.box/master/tutorials/data/2.PNG)
``` bash
chmod 400 EUW.pem
ssh -i "EUW.pem" ec2-user@ec2-54-201-70-167.eu-west-2.compute.amazonaws.com
```
