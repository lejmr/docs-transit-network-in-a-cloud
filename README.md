# Example of Inter-region transition gateway peering

This repository is just a time capsule trying to catch information about building transit gateway onto one place. The goal is to deliver inter-region communication among VPCs.

![High level diagram](files/tgw-inter-region-peering-example.png)


```
cd Region1
terraform init
terraform apply
```


```
cd Region2
terraform init
terraform apply
```

Create TGW connections