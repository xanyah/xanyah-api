# frozen_string_literal: true

S3_CLIENT = Aws::S3::Client.new(
  region:      ENV['S3_REGION'],
  credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
)

S3_BUCKET = Aws::S3::Resource.new(client: S3_CLIENT).bucket(ENV['S3_BUCKET'])
