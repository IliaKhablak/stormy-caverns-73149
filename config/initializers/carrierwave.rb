CarrierWave.configure do |config|

  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['aws_id'],
      aws_secret_access_key: ENV['aws_secret'],
      region:                'ap-southeast-1',
      endpoint: 'https://s3.amazonaws.com'
  }

  
  config.fog_directory  = 'enotikbucket'
  config.fog_public = false
  config.storage = :fog
  
end
