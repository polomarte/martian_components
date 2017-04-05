class Component < ActiveRecord::Base
  @@permitted_params = [:h1, :h2, :text, :link_url, :link_label, :published]

  include Imageable

  store :data, accessors: [:options, :form_options]
  translates :title, :h1, :h2, :text, :link_url, :link_label

  validates :key, :title, presence: true
  validates :key, uniqueness: true
  validates :link_url, presence: true, if: ->{link_label.present?}

  belongs_to :parent, class_name: 'Component', inverse_of: :items,
    foreign_key: 'parent_id', touch: true

  has_many :items, ->{order [position: :asc, id: :asc]}, class_name: 'Component',
    inverse_of: :parent, foreign_key: 'parent_id', dependent: :destroy

  scope :published, ->{where(published: true)}

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

  def modal_id
    ['component', self.class.to_s.underscore.dasherize, 'modal', key.parameterize].join('-')
  end
end
