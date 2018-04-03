require 'aws-sdk'
Aws.config.update({
  region: 'ap-southeast-1',
  credentials: Aws::Credentials.new(ENV['aws_id'], ENV['aws_secret']),
})

S3_BUCKET = Aws::S3::Resource.new.bucket('enotikbucket')
