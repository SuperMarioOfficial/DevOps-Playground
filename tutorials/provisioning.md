## Provisioning
Provisioning can be done in many stages and not only here, and in different ways. [Provisioners](https://packer.io/docs/provisioners/shell.html) use builtin and third-party software to install and configure the machine image after booting. Provisioners prepare the system for use, so common use cases for provisioners include:
- installing packages
- patching the kernel
- creating users
- downloading application code
### It can happen in different ways such as
- inline
- shell
- ansible
- vagrant
```
   "provisioners": [
    		{
      "type": "shell",
      "execute_command": "echo '{{user `ssh_password`}}' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'",
      "scripts": [ "{{template_dir}}/scripts/cleanup.sh"],
      "expect_disconnect": true
      }]
```

```
 "provisioners": [
{
  "type": "shell",
  "inline": [
    "sudo apt-get install -y git",
    "ssh-keyscan github.com >> ~/.ssh/known_hosts",
    "git clone git@github.com:exampleorg/myprivaterepo.git"
  ]
}]
```
### Examples: 
- [bonzofenix/scripts](https://github.com/bonzofenix/trainings/tree/master/bosh-lite/scripts)
- [xuxiaodong/scripts](https://github.com/xuxiaodong/kvm-example/tree/df0bbad6b0071bdd29d83ad4a5ee965fcd71e819/scripts)

![](https://raw.githubusercontent.com/frankietyrine/K-OSINT.iso/master/unnamed.png)
