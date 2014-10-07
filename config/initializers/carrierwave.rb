CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => Figaro.env.S3_KEY,
    :aws_secret_access_key  => Figaro.env.S3_SECRET,
    :region                 => Figaro.env.S3_REGION
  }
  config.fog_directory  = Figaro.env.S3_BUCKET
end