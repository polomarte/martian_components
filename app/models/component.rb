class Component < ActiveRecord::Base
  @@permitted_params = [:h1, :h2, :text]

  include Imageable

  define_image_kinds [:image, :icon, :background]

  store :data, accessors: [:options, :form_options]
  translates :title, :h1, :h2, :text

  validates :key, presence: true
  validates :key, uniqueness: true
  validates :title, presence: true, if: ->(c) { c.h1.blank? }

  belongs_to :parent, class_name: 'Component', inverse_of: :items,
    foreign_key: 'parent_id', touch: true

  has_many :items, -> { order [id: :asc] }, class_name: 'Component',
    inverse_of: :parent, foreign_key: 'parent_id', dependent: :destroy

  after_save :reload_related_active_admin_resource!

  def self.[] key
    raise 'Invalid key format' unless valid_key?(key)
    subclass_based_on_key(key).find_by(key: key)
  end

  def self.valid_key? key
    key.respond_to?(:split) && (key.chomp(':').split(':').size == 3)
  end

  def self.subclass_based_on_key key
    self.new.subclass_based_on_key key
  end

  def self.permitted_params
    @@permitted_params
  end

  def subclass_based_on_key key=nil
    key = key || self.key
    page, component, page_location = key.split(':')
    component.camelcase.constantize
  end

  # def items
  #   items_keys.map{|key| Component[key]}
  # end

  def anchor_name
    (title || h1).parameterize
  end

  def to_partial_path
    "components/#{self.class.name.underscore}/#{self.class.name.underscore}"
  end

  def to_form_path
    "components/#{self.class.name.underscore}/form"
  end

  def options
    super || {}
  end

  def form_options
    super || {}
  end

  def css_class
    "component-#{self.class.to_s.underscore.dasherize}"
  end

private

  def reload_related_active_admin_resource!
    admin = ActiveAdmin.application.namespace(:admin)

    page_resource = admin.resources.to_a.find do |res|
      next unless res.is_a? ActiveAdmin::Page
      res.name.in? [key, parent.try(:key)]
    end

    return if page_resource.blank?
    return if page_resource.menu_item.blank?

    component = self
    admin.send :parse_page_registration_block, page_resource do
      menu(
        parent:   page_resource.menu_item.parent.label,
        priority: page_resource.menu_item.priority,
        label:    component.decorate.title)

      content title: component.decorate.title do
        columns do
          column do
            if parent = component.parent
              render parent.to_form_path, component: parent
            else
              render component.to_form_path, component: component
            end
          end
        end
      end
    end
  end
end

class Collapse < Component
  TEXT_SPLITTER = '[[more]]'.freeze

  store_accessor :data, :nested_component_key, :file_caption
  mount_uploader :file, FileUploader

  def self.permitted_params
    super | [:file, :file_cache, :file_caption, :remove_file]
  end

  def nested_component
    if nested_component_key
      Component[nested_component_key]
    end
  end

  def text_with_manual_division?
    text[TEXT_SPLITTER].present?
  end
end

class Content < Component
end

class Tabs < Component
end

class Banner < Component
end

class HoverGroup < Component
end

class HoverItem < Component
  store_accessor :data, :link_url

  def self.permitted_params
    super | [:link_url]
  end

  def video_id
    return nil if link_url.blank?
    uri = URI.parse(link_url)
    return nil unless uri.host.include? 'youtube'

    CGI.parse(uri.query)['v'][0]
  end

  def options
    options = super
    options[:modal] = true if video_id.present?
    options
  end
end

class Timeline < Component
end

class MegaLink < Component
  store_accessor :data, :link_url
  validates :link_url, presence: true, if: ->(r) { r.file.blank? }

  mount_uploader :file, FileUploader

  def self.permitted_params
    super | [:link_url, :file, :file_cache]
  end
end

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
end

class Gallery < Component
  has_many :gallery_assets, ->{order(:position)}, dependent: :destroy

  def self.permitted_params
    super | [{gallery_assets_attributes: GalleryAsset.permitted_params}]
  end

  accepts_nested_attributes_for :gallery_assets, allow_destroy: true, reject_if: :all_blank
end
