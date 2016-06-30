class SocialFeeds < Component
  class Feed
    include ActiveModel::Model

    attr_accessor :platform, :text, :image, :published_at, :source_link, :icon_path

    def initialize raw_feed, platform
      @raw_feed = raw_feed
      self.platform = platform
      public_send("build_#{platform}")
    end

    def build_custom
      self.text         = @raw_feed.text
      self.published_at = @raw_feed.published_at
      self.source_link  = @raw_feed.source_link
      self.image        = @raw_feed.image
      self.icon_path    = @raw_feed.icon_path
    end

    def build_facebook
      self.text         = @raw_feed['message']
      self.published_at = DateTime.parse @raw_feed['created_time']
      self.source_link  = @raw_feed['link']
      self.image        = @raw_feed['full_picture']
    end

    def build_youtube
      self.text         = @raw_feed.css('title').inner_text
      self.published_at = DateTime.parse(@raw_feed.css('published').inner_text)
      self.source_link  = @raw_feed.css('link').attribute('href').value
      self.image        = @raw_feed.at('//media:group/media:thumbnail').attribute('url').value
    end

    def build_twitter
      self.text         = @raw_feed.text
      self.published_at = @raw_feed.created_at.to_datetime
      self.source_link  = @raw_feed.uri.to_s
      self.image        = @raw_feed.media.select { |m|
        m.is_a? Twitter::Media::Photo}.first.try(:media_url).try(:to_s)
    end

    def video_id
      return nil if platform != :youtube
      uri = URI.parse(source_link)
      return nil unless uri.host.include? 'youtube'

      CGI.parse(uri.query)['v'][0]
    end

    def to_partial_path
      'components/social_feeds/feed'
    end

    def to_key
      ['social-feed', platform]
    end

    def param_key
      'feed'
    end
  end

  store_accessor :data,
    :fb_fanpage_id, :fb_permanent_fanpage_token,
    :youtube_channel_id, :twitter_user

  def self.permitted_params
    super | [:fb_fanpage_id, :fb_permanent_fanpage_token, :youtube_channel_id, :twitter_user]
  end

  def feeds
    feeds = []

    if fb_fanpage_id.present? && fb_permanent_fanpage_token.present?
      fb_feeds = FetchFacebookPageFeedsService.perform(fb_fanpage_id, token: fb_permanent_fanpage_token)
      feeds << Feed.new(fb_feeds.first, :facebook) if fb_feeds.any?
    end

    if youtube_channel_id.present?
      youtube_feeds = FetchYoutubeFeedsService.perform(youtube_channel_id)
      feeds << Feed.new(youtube_feeds.first, :youtube) if youtube_feeds.any?
    end

    if twitter_user.present?
      twitter_feeds = FetchTwitterFeedsService.perform(twitter_user)
      feeds << Feed.new(twitter_feeds.first, :twitter) if twitter_feeds.any?
    end

    feeds
  end

  def all_feeds
    feeds | (options[:custom_feeds] || [])
  end
end
