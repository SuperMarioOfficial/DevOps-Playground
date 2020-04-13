### Deploy an AWS instance with packer 
```
{
  "variables": {
    "aws_access_key": "",
    "aws_secret_key": "",
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
"ssh_username":"admin",
"ssh_private_key_file":"test_pair.pem",
"ami_name": "test_54354672",
     "ami_description": "test_description", 
     "tags": {
       "role": "test_role"
     },
     "run_tags": {
       "role": "test_tag"
     }
 }],  

    "type": "shell",
      "execute_command": "echo '{{user `ssh_password`}}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'",
      "scripts": ["{{template_dir}}/scripts/ansible.sh"],
      "expect_disconnect": true
      }]
}
```

## connect to the AWS instance
### Download from aws you pem file
![](https://raw.githubusercontent.com/SuperMarioOfficial/Build-your-own-vagrant.box/master/tutorials/data/1.PNG)
### Open a terminal
![](https://raw.githubusercontent.com/SuperMarioOfficial/Build-your-own-vagrant.box/master/tutorials/data/2.PNG)
``` bash
chmod 400 755485601581.pem
ssh -i "755485601581.pem" ec2-user@ec2-54-201-70-167.us-west-2.compute.amazonaws.com
```
