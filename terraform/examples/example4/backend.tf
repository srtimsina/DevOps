terraform {
    backend "s3" {
        bucket = "terraform-state-sti"
        key = "terrform/backend"
        region = "us-east-2"
    }
}
