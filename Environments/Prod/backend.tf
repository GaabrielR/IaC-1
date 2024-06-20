terraform {
  backend "s3" {
    bucket = "terraform-state-alura-gabrielrocha"
    key    = "Prod/terraform.tfstate"
    region = "us-west-2"
  }
}