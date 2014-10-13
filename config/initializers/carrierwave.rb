if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => Figaro.env.S3_KEY,
      :aws_secret_access_key  => Figaro.env.S3_SECRET,
      :region                 => Figaro.env.S3_REGION
    }
    config.fog_directory  = Figaro.env.S3_BUCKET
  end
end
