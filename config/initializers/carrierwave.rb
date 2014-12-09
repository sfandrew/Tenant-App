CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJCYZENE5L2JJ5R5A',                        # required
    :aws_secret_access_key  => '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',                        # required
    :region                 => 'us-west-1'                  # optional, defaults to 'us-east-1'
    # :host                   => 's3.example.com',             # optional, defaults to nil
    # :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
  }

  # set aws environment variables on your terminal
  # export AWS_ACCESS_KEY_ID=AKIAJCYZENE5L2JJ5R5A
  # export AWS_ACCESS_SECRET_KEY_ID=rYYQHUQB5qxbvSoA9EU7yEQbBJJLkPOBMMORk4UA
  # export S3_BUCKET=tenant-dev
  config.fog_directory  = 'tenant-dev'                            # required
  config.fog_public     = false                                   # optional, defaults to true
    # optional, defaults to {}
end

