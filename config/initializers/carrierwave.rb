CarrierWave.configure do |config|
  case Rails.env.to_sym
  when :production #, :development
    config.fog_credentials = {
      provider:               'AWS',
      aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],
      region:                 'us-east-1'
    }
    config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}
    config.fog_directory  = 'brewdega-cellar'
    config.fog_use_ssl_for_aws = true
    config.storage = :fog

  when :staging
    config.fog_credentials = {
      provider:               'AWS',
      aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],
      region:                 'us-east-1'
    }
    config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}
    config.fog_directory  = 'brewdega-cellar-staging'
    config.fog_use_ssl_for_aws = true
    config.storage = :fog

  when :development
    config.storage = :file
    config.enable_processing = true

  when :test
    config.storage = :file
    config.enable_processing = false

  else
    fail "Missing Carrierwave configuration. See: #{__FILE__}"
  end
end
