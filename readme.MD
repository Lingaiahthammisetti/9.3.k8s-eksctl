# Note: When you create an EKS cluster with eksctl, it generates a kubeconfig file that kubectl uses to connect to the cluster.
```
eksctl create cluster --config-file=eks.yaml
```
```
aws eks update-kubeconfig --region us-east-1 --name expense
```
```
eksctl delete cluster --config-file=eks.yaml
```


# What are difference between roles: DevOps Engineer, SRE, Cloud Engineers, Platform Engineers?#

DevOps engineers automate workflows, code infrastructure, and ensure smooth deployments(Tools: Jenkins, Docker, Kubernetes).

SRE automates software installation and system management using tools like Python for scripting and Prometheus for monitoring and alerting.(Tools: Python, Prometheus)

Cloud engineers design and manage cloud infrastructure, including provisioning, scaling, and optimizing resources.(Tools: AWS, Azure Terraform)

Platform engineers build and maintain application platforms, ensuring they are reliable, scalable, and efficient for development and deployment.(Tools: GitLab CI, Docker, Kubernetes)

Cloud engineers manage cloud infrastructure, while platform engineers build and maintain application platforms.