resource "aws_iam_user" "harish01" {
  name = "harish01"
  path = "/"
}

resource "aws_iam_access_key" "harish01_key" {
  user = aws_iam_user.harish01.name
}

data "aws_iam_policy_document" "harish01_role" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "harish01_attach" {
  name   = "harish-policy"
  user   = aws_iam_user.harish01.name
  policy = data.aws_iam_policy_document.harish01_role.json
}