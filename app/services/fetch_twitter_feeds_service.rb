# Before use this service, check if YOUTUBE_CHANNEL_ID env var exists.
# To get this, enter in https://www.youtube.com/account_advanced as account owner.

class FetchTwitterFeedsService
  def self.perform *args
    new.perform *args
  end

  def perform user
    @api = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end

    @api.user_timeline(user).select {|feed| !feed.reply?}
  end
end
