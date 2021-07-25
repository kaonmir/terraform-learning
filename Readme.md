# Terraform Learning

## 🖥 Overview

This is a repository for learning Terraform, a open-source IaaS (infrasturcture as a code)

Why I'm studying this tech is to **define** a AWS resources with written code. I was getting trouble with configuring the AWS resources; EC2, RDS, VPC, ...

Terraform let me release from these freaking duties. Of course I must make me familiar with confiuring. To be a Devops developer, let's get into it.  

## 📚 Learning Course

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

## 😮‍💨 푸념

### 25 JUL 2021 11:19

vscode에서 variable list나 object를 intellisense가 반응하지 않는다. deprecated 된 줄 알았는데 `terraform console` 명령어로 변수를 찍어보니까 멀쩡히 나온다. 이 말인 즉슨, 그냥 vscode에서만 영 인식을 잘 못 한단 것이다. 그냥 쓸 지 아니면 string으로만 해서 답답함의 한계에 부딪칠 때까지 쓸 지 고민이다.

### 26 JUL 2021 06:47

반응하지 않는 게 아니다. 빨간색으로 표시돼서 그렇게 생각했는데 그냥 list, map은 빨간색으로 표시되는 것 같다. 동작도 잘하고 intellisense도 반응한다. 다만, object는 반응하지 않는다.

4번 과제를 진행하고 있는데 계속 에러가 난다.

``` Text
Error: Error creating ENI: InvalidGroup.NotFound: You have specified two resources that belong to different networks.
       status code: 400, request id: 3990b416-9203-4257-91df-15b7ff54ac22
    with aws_network_interface.worker_node_nic,
    on ec2_instance.tf line 3, in resource "aws_network_interface" "worker_node_nic":
    3: resource "aws_network_interface" "worker_node_nic" {
```

3번 과제의 대부분을 복사했는데 왜 안나오는지 모르겠다...

### 26 JUL 2021 07:10

이유를 찾았다. security group에도 vpc가 있는지 몰랐다. 새로 security group을 만들고 하나의 vpc로 통일하니 무사히 성공했다.
