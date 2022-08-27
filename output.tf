output "s3_name" {
  value = aws_s3_bucket.devopss3.id

}
output "s3_region" {
  value = aws_s3_bucket.devopss3.region
}

output "endpoint" {
  value = aws_eks_cluster.devopseks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.devopseks.certificate_authority[0].data
}
