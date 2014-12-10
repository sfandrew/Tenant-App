CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV['S3_KEY'],                        # required
    :aws_secret_access_key  => ENV['S3_SECRET'],                       # required
    :region                 => 'us-west-1'                  # optional, defaults to 'us-east-1'
    # :host                   => 's3.example.com',             # optional, defaults to nil
    # :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
  }

  # set aws environment variables on your terminal
  # export S3_KEY=AKIAJCYZENE5L2JJ5R5A
  # export S3_SECRET=rYYQHUQB5qxbvSoA9EU7yEQbBJJLkPOBMMORk4UA
  # to make settings permanent
  # vi ~/.bash_proflle
  # S3_KEY=AKIAJCYZENE5L2JJ5R5A
  # S3_SECRET=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
  #  export S3_KEY
  #  export S3_SECRET
  config.fog_directory  = 'tenant-dev'                            # required
  config.fog_public     = false                                   # optional, defaults to true
    # optional, defaults to {}
end

