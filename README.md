# AWS Infrastructure Automation with Terraform

A multi-tier AWS infrastructure project built with Terraform, demonstrating Infrastructure as Code (IaC) principles — VPC networking, EC2 compute, and RDS database provisioning, fully modularized and version-controlled.

Built as a hands-on learning project to move from cloud incident management into infrastructure engineering — every module here was written, planned, applied, and verified manually before moving to the next.

---

## Architecture Overview

*(Diagram will be added with a proper architecture image once EC2 + RDS modules are complete)*

---

## Tech Stack

- **Terraform** — Infrastructure as Code
- **AWS** — VPC, EC2, RDS
- **AWS CLI** — authentication and resource verification
- **Git / GitHub** — version control
- **VS Code** — development environment, with HashiCorp Terraform extension

---

## Prerequisites

- AWS account with an IAM user (not root) configured with programmatic access
- AWS CLI v2 installed and configured (`aws configure`)
- Terraform >= 1.5.0
- VS Code with the **HashiCorp Terraform** extension installed
- Git

---

## Project Structure

```
terraform-aws-infrastructure/
├── main.tf                 # Root module — wires all child modules together
├── variables.tf             # Root-level input variables
├── outputs.tf               # Root-level outputs
├── terraform.tfvars          # Actual variable values (gitignored)
├── .gitignore
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── rds/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── docs/
    └── screenshots/
```

---

## Module 1: VPC — Networking Foundation ✅

**What it builds:** A custom VPC with one public subnet (internet-facing) and one private subnet (internal-only), connected via an Internet Gateway and a route table.

**Why this design:** Public/private subnet separation is a core AWS security pattern. Internet-facing resources (like the EC2 web server) sit in the public subnet, while sensitive resources (like the RDS database) stay isolated in the private subnet with no direct internet exposure — following the principle of least privilege at the network level.

**Resources created:**
- 1 VPC (`10.0.0.0/16`)
- 1 public subnet (`10.0.1.0/24`)
- 1 private subnet (`10.0.2.0/24`)
- 1 Internet Gateway
- 1 public route table + association

### Steps taken

1. Configured AWS CLI with IAM credentials and verified authentication
2. Wrote `modules/vpc/main.tf`, `variables.tf`, `outputs.tf`
3. Wired the VPC module into the root `main.tf`
4. Ran `terraform init` to download and initialize the AWS provider plugin
5. Ran `terraform plan` to preview the 6 resources before creating anything in AWS
6. Ran `terraform apply` to provision the VPC, subnets, Internet Gateway, and route table
7. Verified the created resources directly in the AWS Console (`ap-south-1` / Mumbai region)

### Screenshots

**AWS CLI authenticated and initialized:**

![Terraform Init](docs/screenshots/tfinit.png)

**`terraform plan` — dry run showing exactly what will be created before touching AWS:**

![Terraform Plan](docs/screenshots/tfdryrun.png)

**`terraform apply` — resources actually created in AWS:**

![Terraform Apply](docs/screenshots/tfapply.png)

**AWS Console verification — `nv-infra-vpc` live in `ap-south-1`:**

![VPC Console](docs/screenshots/vpc-console.png)

---

## Module 2: EC2 — Compute Layer 🚧
*(in progress)*

**What it will build:** A security group (firewall rules for SSH + HTTP access) and an EC2 instance placed in the public subnet, with a startup script that automatically installs and configures a web server on boot.

---

## Module 3: RDS — Database Layer ⏳
*(pending)*

**What it will build:** A MySQL database instance inside the private subnet, with a security group that only trusts inbound traffic from the EC2 instance's security group — never directly from the internet.

---

## Key Terraform Concepts Demonstrated

- **Modular infrastructure design** — each layer (VPC, EC2, RDS) is a self-contained, reusable module
- **Variables and outputs** — modules communicate via declared inputs/outputs rather than hardcoded values, the same way functions pass parameters and return values
- **Implicit dependency resolution** — Terraform automatically determines build order (e.g. VPC before subnets, subnets before EC2) based on resource references, without manual sequencing
- **Plan-before-apply workflow** — every change is previewed with `terraform plan` before being applied, preventing unintended infrastructure changes
- **Security best practices** — private subnet isolation for databases, least-privilege security group rules (SSH locked to a single IP, not `0.0.0.0/0`)
- **State management** — Terraform's state file tracks real-world resource mapping, excluded from version control via `.gitignore` since it can contain sensitive values

---

## What I Learned

*(fill this in as the project progresses — reflect on what clicked, what was confusing at first, and any real debugging moments, e.g. the "0 added, 0 changed" issue caused by an empty tfvars file)*

---

## Author

**Neha Vadagi**
Cloud Operations Engineer | [LinkedIn](https://www.linkedin.com/in/neha-vadagi-9616731b3/) | [GitHub](https://github.com/nehavadagi)
