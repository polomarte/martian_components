S3FileField.config do |c|
  c.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
  c.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  c.bucket            = ENV['FOG_DIRECTORY']
  c.url               = "http://s3.amazonaws.com/#{ENV['FOG_DIRECTORY']}/"
  c.key_starts_with   = 'uploads/tmp/'
end
