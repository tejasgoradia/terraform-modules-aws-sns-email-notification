# get caller identity
data "aws_caller_identity" "current" {
  # no arguments
}

resource "aws_sns_topic" "sns_topic" {
    name = "${var.application_name}_sns_topic"

    provisioner "local-exec" {
        command = "aws --no-verify-ssl sns subscribe --topic-arn ${self.arn} --protocol ${var.protocol} --notification-endpoint ${var.notification_endpoint}"
    }
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn = "${aws_sns_topic.sns_topic.arn}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "default",
    "Statement":[
        {
            "Sid": "AllowToPublish",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "SNS:Publish",
            "Resource": "${aws_sns_topic.sns_topic.arn}",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceOwner": "${data.aws_caller_identity.current.account_id}"
                }
            }
        }
    ]
}
POLICY
}
