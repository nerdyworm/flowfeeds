CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  else
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV["S3_KEY"],
      :aws_secret_access_key  => ENV["S3_SEC"],
      :region                 => 'us-east-1'
    }
    config.fog_directory  = "flowfeeds"
    config.fog_public     = true
    config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}
  end
end
