resource "aws_s3_bucket" "devopss3" {
  bucket = "devopsautomations"
}

resource "aws_eks_cluster" "devopseks" {
  name     = "4LinuxCluster"
  role_arn = aws_iam_role.eksiam.arn
  
  vpc_config {
    endpoint_private_access = true
    endpoint_public_access = true
    subnet_ids = [aws_subnet.eks-public-subnet.id, aws_subnet.eks-private-subnet-1.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.devopseks-AmazonEKSClusterPolicy,
  ]
}