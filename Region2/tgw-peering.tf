// Not YET implemented by AWS Provider for Terraform
// https://github.com/terraform-providers/terraform-provider-aws/pull/11185
// https://github.com/terraform-providers/terraform-provider-aws/pull/11162
// https://github.com/terraform-providers/terraform-provider-aws/issues/11117

// Amazon AWS official documentation:
// https://docs.aws.amazon.com/cli/latest/reference/ec2/create-transit-gateway-peering-attachment.html

// Official example:
// aws ec2 create-transit-gateway-peering-attachment \
//     --transit-gateway-id tgw-123abc05e04123abc \
//     --peer-transit-gateway-id tgw-11223344aabbcc112 \
//     --peer-account-id 123456789012 \
//     --peer-region us-east-2