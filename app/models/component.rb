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

  has_many :items, -> { order [position: :asc, id: :asc] }, class_name: 'Component',
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
