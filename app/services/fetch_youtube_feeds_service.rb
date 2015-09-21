# Before use this service, check if YOUTUBE_CHANNEL_ID env var exists.
# To get this, enter in https://www.youtube.com/account_advanced as account owner.

class FetchYoutubeFeedsService
  def self.perform *args
    new.perform *args
  end

  def perform youtube_channel_id
    base_url = 'http://www.youtube.com/feeds/videos.xml'
    raw_result = Net::HTTP.get(URI.parse("#{base_url}?channel_id=#{youtube_channel_id}"))
    result = Nokogiri::XML.parse(raw_result)
    result.css('entry')
  end
end
