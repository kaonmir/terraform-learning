# Terraform Learning

## ๐ฅ Overview

This is a repository for learning Terraform, a open-source IaaS (infrasturcture as a code)

Why I'm studying this tech is to **define** a AWS resources with written code. I was getting trouble with configuring the AWS resources; EC2, RDS, VPC, ...

Terraform let me release from these freaking duties. Of course I must make me familiar with confiuring. To be a Devops developer, let's get into it.  

## ๐ Learning Course

### 1. learn-terraform-aws-instance

This is what I made with followning the official document of Terraform.
[Link](https://learn.hashicorp.com/collections/terraform/aws-get-started)

### 2. terraform-course-practice

This is what I made with followning the youtube for CrashCourse. [Link](https://www.youtube.com/watch?v=SLB_c_ayRMo)

Now I'm available to define not only AWS Instance but also  EIP, Internet Gateway, ...

However, I'm **failed** with adding a user_data to AWS Instance with separating a user_data file. I should study more to accomplish it

### 3. rds-db-instance

This is what I made without following any instruction.

It's simple, and I'm looking forward to making whole project with terraform file. It means I make terraform available to make mandatory conneciton for each instances.

## ๐ฎโ๐จ ํธ๋

### 25 JUL 2021 11:19

vscode์์ variable list๋ object๋ฅผ intellisense๊ฐ ๋ฐ์ํ์ง ์๋๋ค. deprecated ๋ ์ค ์์๋๋ฐ `terraform console` ๋ช๋ น์ด๋ก ๋ณ์๋ฅผ ์ฐ์ด๋ณด๋๊น ๋ฉ์ฉกํ ๋์จ๋ค. ์ด ๋ง์ธ ์ฆ์จ, ๊ทธ๋ฅ vscode์์๋ง ์ ์ธ์์ ์ ๋ชป ํ๋จ ๊ฒ์ด๋ค. ๊ทธ๋ฅ ์ธ ์ง ์๋๋ฉด string์ผ๋ก๋ง ํด์ ๋ต๋ตํจ์ ํ๊ณ์ ๋ถ๋ช์น  ๋๊น์ง ์ธ ์ง ๊ณ ๋ฏผ์ด๋ค.

### 26 JUL 2021 06:47

๋ฐ์ํ์ง ์๋ ๊ฒ ์๋๋ค. ๋นจ๊ฐ์์ผ๋ก ํ์๋ผ์ ๊ทธ๋ ๊ฒ ์๊ฐํ๋๋ฐ ๊ทธ๋ฅ list, map์ ๋นจ๊ฐ์์ผ๋ก ํ์๋๋ ๊ฒ ๊ฐ๋ค. ๋์๋ ์ํ๊ณ  intellisense๋ ๋ฐ์ํ๋ค. ๋ค๋ง, object๋ ๋ฐ์ํ์ง ์๋๋ค.

4๋ฒ ๊ณผ์ ๋ฅผ ์งํํ๊ณ  ์๋๋ฐ ๊ณ์ ์๋ฌ๊ฐ ๋๋ค.

``` Text
Error: Error creating ENI: InvalidGroup.NotFound: You have specified two resources that belong to different networks.
       status code: 400, request id: 3990b416-9203-4257-91df-15b7ff54ac22
    with aws_network_interface.worker_node_nic,
    on ec2_instance.tf line 3, in resource "aws_network_interface" "worker_node_nic":
    3: resource "aws_network_interface" "worker_node_nic" {
```

3๋ฒ ๊ณผ์ ์ ๋๋ถ๋ถ์ ๋ณต์ฌํ๋๋ฐ ์ ์๋์ค๋์ง ๋ชจ๋ฅด๊ฒ ๋ค...

### 26 JUL 2021 07:10

์ด์ ๋ฅผ ์ฐพ์๋ค. security group์๋ vpc๊ฐ ์๋์ง ๋ชฐ๋๋ค. ์๋ก security group์ ๋ง๋ค๊ณ  ํ๋์ vpc๋ก ํต์ผํ๋ ๋ฌด์ฌํ ์ฑ๊ณตํ๋ค.
