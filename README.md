# 🌩️ CloudSleuth - AWS Disaster Recovery with Global Accelerator

## 📖 Project Overview

This project demonstrates a **real-world disaster recovery (DR) solution** for AWS that maintains **consistent endpoints during failover** using **AWS Global Accelerator**. Unlike traditional DNS-based failover, this architecture ensures seamless traffic redirection while preserving static IP addresses.

The solution was built with **Terraform** for infrastructure as code, **CloudWatch & Route 53** for monitoring, and **AWS Lambda + SSM Automation** for automated failover.

## 🏗️ Architecture Overview

![CloudSleuth AWS Disaster Recovery Architecture](CloudSleuth%20Architecture.jpeg)


## 🚀 Project Phases

### **Phase 1 – Infrastructure as Code**

- Multi-region Terraform configurations
- Networking setup in both regions
- Global Accelerator for static endpoints
- Active primary EC2 + standby secondary EC2

### **Phase 2 – Monitoring**

- Route 53 health checks for failure detection
- CloudWatch alarms for alerting
- SNS + Lambda integration

### **Phase 3 – Automated Recovery**

- Lambda triggers SSM automation document
- Starts secondary EC2 instance
- Updates Global Accelerator endpoint weights
- Ensures client IP preservation

### **Phase 4 – Testing & Validation**

- Simulated failure of primary server
- Verified automatic detection & failover
- Measured recovery time & endpoint consistency
- Confirmed end-to-end automated recovery

## ✅ Success Criteria

- Multi-region infrastructure deployed via Terraform
- Global Accelerator maintains consistent endpoints
- Route 53 + CloudWatch accurately detects failures
- Lambda + SSM automate failover without manual intervention
- Recovery process validated through testing

## 🔮 Future Improvements

- Multi-AZ replication for stronger resiliency
- Load balancing between active-active regions
- Automated cost optimisation checks
- Integration with AWS Backup service

## 🛠️ Technologies Used

- **Terraform** – Infrastructure as Code
- **AWS Global Accelerator** – Static IP failover routing
- **Amazon Route 53** – Health checks
- **Amazon CloudWatch** – Monitoring & alarms
- **AWS SNS** – Notifications
- **AWS Lambda** – Event-driven automation
- **AWS Systems Manager (SSM)** – Recovery automation

## 📜 Lessons Learned

- Multi-region Terraform requires careful provider configuration
- IAM permissions are critical for cross-region automation
- CloudWatch alarm thresholds must be tuned to avoid false positives
- Automation testing is as important as infrastructure setup

👉 This project showcases my ability to **design, implement, and automate disaster recovery in AWS** with production-grade tooling.
