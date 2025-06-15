# cloudsleuth-dr
A disaster recovery implementation with a fault-tolerant infrastructure that maintains eendpoint consistency during failover.

**Project Brief**

**Understanding the Client's Vision**

CloudSleuth aims to demonstrate a real-world disaster recovery implementation where an organization requires fault-tolerant infrastructure that maintains endpoint consistency during failover. This project has tested my ability to implement infrastructure as code, configure monitoring systems, and develop automated recovery mechanisms using AWS Global Accelerator.

The client requires their web application to remain accessible via the same endpoints even during regional failures, while meeting specific recovery objectives and maintaining a cost-efficient architecture.

**The Problem Landscape
Let's examine the key challenges this project addresses:**

- Infrastructure Deployment Challenges

- Terraform configurations requiring multi-region resource management

- Dependencies between resources across different AWS regions

- Proper provider configuration for cross-region operations

- Monitoring and Detection Considerations

- Configuring appropriate health checks for accurate failure detection

- Setting CloudWatch alarm thresholds to avoid false positives

- Creating notification pathways that trigger automated responses

- Failover Automation Complexities

- Ensuring Lambda functions include proper AWS SDK configurations

- Formatting SSM document parameters correctly for API compatibility

- Managing IAM permissions across regional boundaries

**Solution Requirements**

**Phase 1: Infrastructure as Code Implementation**
- Resource Definition

- Create Terraform configurations for multi-region deployment

- Define networking components in both primary and secondary regions

- Configure Global Accelerator for consistent endpoint access

- Web Server Implementation

- Deploy primary web server in active state

- Configure secondary server in stopped state (pilot light)

- Set up security groups for appropriate access control

**Phase 2: Monitoring System Configuration**
- Health Check Setup

- Implement Route53 health checks for application monitoring

- Create CloudWatch alarms with appropriate thresholds

- Configure SNS topics for notification delivery

- Alert Integration

- Set up Lambda function with proper IAM permissions

- Configure integration between SNS and Lambda

- Test alarm propagation through the notification chain

**Phase 3: Automated Recovery Development**
- Automation Document Creation

- Design SSM document with appropriate workflow steps

- Configure proper parameter handling for cross-region operations

- Include verification steps for recovery confirmation

- Endpoint Management

- Configure Global Accelerator endpoint weights

- Implement automation for traffic shifting during failover

- Ensure client IP preservation during endpoint transitions

**Phase 4: Testing and Validation**
- Failure Scenario Testing

- Simulate primary web server failure

- Verify automatic detection and notification

- Measure recovery time and endpoint consistency

- Integration Verification

- Confirm Lambda function properly processes alerts

- Verify SSM document executes all required steps

- Ensure Global Accelerator properly redirects traffic
