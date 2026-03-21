# Harness IACM Terraform Modules  
A clean, versioned library of reusable Terraform modules designed for Harness IACM workflows. Enables controlled infrastructure composition, module versioning, and repeatable deployment patterns.

This repository is built for Solutions Engineers, platform teams, and customers who want a practical, minimal way to standardize infrastructure using modular Terraform and Harness.

## 🎯 Purpose  
This project demonstrates:

- Reusable Terraform modules (EC2, VPC, etc.)  
- Versioned infrastructure components via Git tags  
- Clean separation between module design and consumption  
- Controlled infrastructure changes through version pinning  
- Repeatable patterns for Harness IACM-driven deployments  
- Seamless integration with Harness pipelines for promotion workflows  

The emphasis is on clarity, composability, and real-world usability.

## 🏗 Architecture Overview  

### Layer 1 — Modules (this repo)  
Reusable infrastructure building blocks.

Examples:
- EC2 instance module  
- VPC module (future)  
- Security groups, networking, etc.  

Each module:
- Encapsulates a single responsibility  
- Is versioned via Git tags (`v1.0.0`, `v1.1.0`)  
- Is consumed externally via source + ref  

This layer represents the **infrastructure library**.

### Layer 2 — Consumption (external repo)  
Where modules are assembled into real environments.

Examples:
- Dev / staging / prod configurations  
- Version-pinned module usage  
- Environment-specific inputs  
- Executed and managed through Harness IACM workspaces  

This layer represents the **live infrastructure state**.

## 📁 Repository Structure  
.
├── modules/  
│   ├── ec2/  
│   │   ├── main.tf  
│   │   ├── variables.tf  
│   │   └── outputs.tf  
│   │  
│   └── vpc/  (future)  

## 🚀 How It Works  

### 1. Define a module  
Build a reusable component inside `modules/`

### 2. Version it  
```
git tag v1.0.0
git push --tags
```

### 3. Consume it  
From a separate Terraform root:

```
module "ec2" {
  source = "git::https://github.com/aedifex/harness-iacm-terraform-modules.git//modules/ec2?ref=v1.0.0"
}
```

### 4. Promote changes  
- Update module  
- Tag new version (`v1.1.0`)  
- Update `ref` in consumer  
- Apply via Harness IACM

## 🔄 Deployment Pattern  

- Define infrastructure as modules  
- Version modules via Git tags  
- Consume modules with pinned versions  
- Update versions to trigger controlled changes  
- Execute and observe via Harness pipelines and dashboards  

Harness ties this together by:
- Managing Terraform execution and state  
- Enabling promotion pipelines across environments  
- Providing visibility into infrastructure changes over time  

## 💡 Why This Pattern  

This repository enables:

- No copy/paste Terraform  
- Explicit version control of infrastructure  
- Safe upgrades and rollbacks  
- Composable infrastructure design  
- Clear separation of concerns  
- Tight integration with Harness for execution, governance, and visibility  

It mirrors how mature teams treat infrastructure:
as versioned, reusable software artifacts

## ⚠ Notes  

- Modules should remain small and focused  
- Avoid embedding environment-specific logic  
- Version tags should be treated as immutable  
- Consumers should always pin versions (`ref`)  
- Harness IACM manages remote state and execution  

## 👤 Intended Audience  

- Harness Solutions Engineers  
- Platform / DevOps teams  
- Customers evaluating Terraform + IACM patterns  
- Anyone building reusable infrastructure libraries  

Clean. Composable. Harness-native.
