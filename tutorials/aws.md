# AWS 

## EC2 - Amazon Machine Images (AMI)
An Amazon Machine Image (AMI) is a special type of virtual appliance that is used to instantiate (create) a virtual machine within the Amazon Elastic Compute Cloud (""EC2"").
There are three types of EC2 instances: 
- shared tenancy -> sharing hardware with other tenants (sharing a flat)
- dedicated instance -> privileged use of an host hardware (owning a flat)
- dedicated host - > multiple instances, more hardware control (owning a house)
There are two type of storages:
- persistent storage -> separate harddisk not connected with the instance or host
- ephemeral storage -> work like the RAM of a computer 
#### Packer and AMI -> autobuild and configure
- [Building custom AMI using Packer.io](https://medium.com/@sanudatta11/building-custom-ami-using-packer-io-5df55f32ebbb)
#### Vagrant and AMI -> from/to vagrant boxes
- [Using Vagrant with AWS](https://blog.scottlowe.org/2016/09/15/using-vagrant-with-aws/)
- [Deploy vagrant boxes on EC2](https://www.tothenew.com/blog/using-vagrant-to-deploy-aws-ec2-instances/)
#### Ansible and AMI -> provisioning instances
- [Use Ansible to build and manage AWS EC2 instances](https://www.linuxschoolonline.com/use-ansible-to-build-and-manage-aws-ec2-instances/)
- [Getting Started with Ansible and Dynamic Amazon EC2 Inventory Management](https://aws.amazon.com/blogs/apn/getting-started-with-ansible-and-dynamic-amazon-ec2-inventory-management/)
## ECS - Amazon Elastic Container Service 
 - the service allows you to run docker applications across cluster without requiring you to manage the cluster
 - clusters act as a resource pool, aggregating cpu, memory ... clusters dynamically scale instances, but it can only scale in a single region. You can deploy docker applications across your cluster to improve redundancy. 
 - cluster template:
    - AWS Fargate  is an engine used to enable ECS to run containers without managing entire clusters. 
    - EC2 Linux + networking 
    - EC2 Windows + networking
## ECR - Amazon Elastic Container Registry
## EKS - Amazon Elastic Container Service for Kubernetes
## AWS Elastic Beanstalk
## AWS Lambda
## AWS Batch
## 
## Amazon Lightsail


### References 
- [CloudAccademy - Basic AWS](https://cloudacademy.com/course/compute-fundamentals-for-aws/introduction-to-aws-compute-fundamentals/?context_resource=lp&context_id=1)
