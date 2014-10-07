class Component < ActiveRecord::Base
  store :data, accessors: [:options, :form_options, :items_keys]
  translates :h1, :h2, :text

  validates :key, presence: true
  validates :key, uniqueness: true

  has_many :images, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: ->(attrs) {attrs['file'].blank? && attrs['file_cache'].blank?}

  def self.[] key
    subclass_based_on_key(key).find_by(key: key)
  end

  def self.subclass_based_on_key key
    self.new.subclass_based_on_key key
  end

  def self.permitted_params
    [:h1, :h2, :text, images_attributes: Image.permitted_params]
  end

  def subclass_based_on_key key=nil
    key = key || self.key
    page, component, page_location = key.split(':')
    component.camelcase.constantize
  end

  def image
    images.find_by(kind: 'main')
  end

  def icon_image
    images.find_by(kind: 'icon')
  end

  def background_image
    images.find_by(kind: 'background')
  end

  def items
    items_keys.map{|key| Component[key]}
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
end

class Collapse < Component
  store_accessor :data, :nested_component_key

  def nested_component
    if nested_component_key
      Component[nested_component_key]
    end
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
end

class Timeline < Component
end

class MegaLink < Component
  store_accessor :data, :link_url
  validates :link_url, presence: true, if: ->(r) { r.file.blank? }

  mount_uploader :file, ComponentUploaders::Asset

  def self.permitted_params
    super | [:link_url, :file, :file_cache]
  end
end
