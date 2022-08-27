
resource "aws_eks_node_group" "devopseks-nodes" {
  cluster_name    = aws_eks_cluster.devopseks.name
  node_group_name = "Nodes"
  node_role_arn   = aws_iam_role.eksnodeiam.arn
  subnet_ids      = [aws_subnet.eks-private-subnet-1.id]
  instance_types  = ["t3.small"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }


  depends_on = [
    aws_iam_role_policy_attachment.devopseks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.devopseks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.devopseks-AmazonEC2ContainerRegistryReadOnly,
  ]
}