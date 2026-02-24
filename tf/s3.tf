resource "aws_s3_bucket" "code_bucket" {
  bucket = "lti-project-code-bucket-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
}

resource "null_resource" "generate_zip" {
  provisioner "local-exec" {
    command     = "powershell -NoProfile -Command \"if (Test-Path backend) { Compress-Archive -Path backend -DestinationPath backend.zip -Force }; if (Test-Path frontend) { Compress-Archive -Path frontend -DestinationPath frontend.zip -Force }\""
    working_dir = ".."
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "aws_s3_bucket_object" "backend_zip" {
  bucket     = aws_s3_bucket.code_bucket.bucket
  key        = "backend.zip"
  source     = "../backend.zip"
  depends_on = [null_resource.generate_zip]
}

resource "aws_s3_bucket_object" "frontend_zip" {
  bucket     = aws_s3_bucket.code_bucket.bucket
  key        = "frontend.zip"
  source     = "../frontend.zip"
  depends_on = [null_resource.generate_zip]
}
