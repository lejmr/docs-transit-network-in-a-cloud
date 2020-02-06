_This is a work in progress_

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

# Challenges / Contributions welcomed / Information
* All .png files are created using Draw.io, so feel free to modify them locally. 
* Transit gateway allows static routing across regions - how to deal with it
    * AWS Lambda using labels - is there any already existing solution?
* Can we set priority to static routes over peering connections? How overlapping routes are behaving?    
    
    
