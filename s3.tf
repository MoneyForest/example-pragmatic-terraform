# 外部公開しないプライベートバケット
resource "aws_s3_bucket" "private" {
  bucket = "private-pragmatic-terraform-moneyforest"

  # バージョニングを有効にすると以前のバージョンへ復元できるようになる
  versioning {
    enabled = true
  }

  # server_side_encryption_configurationで暗号化を有効にできる
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# ブロックパブリックアクセスを設定すると、予期しないオブジェクトの公開を抑止できる
resource "aws_s3_bucket_public_access_block" "private" {
  bucket                  = aws_s3_bucket.private.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 外部公開するパブリックバケット
resource "aws_s3_bucket" "public" {
  bucket = "public-pragmatic-terraform-moneyforest"
  # アクセス権
  # デフォルトはprivateのため、パブリックバケットの時は明示的に設定する
  acl = "public-read"

  cors_rule {
    allowed_origins = ["https://example.com"]
    allowed_methods = ["GET"]
    allowed_headers = ["*"]
    max_age_seconds = 3000
  }
}

# albのアクセスログ用バケット
resource "aws_s3_bucket" "alb_log" {
  bucket = "alb-log-pragmatic-terraform-moneyforest"

  # ライフサイクルルール
  lifecycle_rule {
    enabled = true

    # 180日経過したファイルを自動的に削除し、無限にファイルが増えないようにする
    expiration {
      days = "180"
    }
  }
}

# バケットポリシー S3バケットへのアクセス権を設定する
# ALBのようなAWSのサービスからS3へ書き込みを行う場合に必要
resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}

data "aws_iam_policy_document" "alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]

    # ALBの場合はAWSが管理しているアカウントから書き込むため
    # そのアカウントIDを指定する（IDはリージョンによって異なる）
    principals {
      type        = "AWS"
      identifiers = ["582318560864"]
    }
  }
}

# オブジェクトが残っているバケットを強制的に削除する
resource "aws_s3_bucket" "force_destroy" {
  bucket        = "force-destroy-pragmatic-terraform-moneyforest"
  force_destroy = true
}
