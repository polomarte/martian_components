require 'active_support/concern'

module Imageable
  extend ActiveSupport::Concern

  included do
    has_many :images, as: :imageable, dependent: :destroy

    accepts_nested_attributes_for :images, allow_destroy: true, reject_if: ->(attrs) {
      attrs['file'].blank? &&
      attrs['file_cache'].blank? &&
      attrs['remote_file_url'].blank?}
  end

  module ClassMethods
    def image_kinds
      raise 'Must implement #image_kinds'
    end

    def define_image_kinds kinds
      kinds.each do |kind|
        define_method kind do
          images.find_by(kind: kind)
        end
      end

      permitted_params = class_variable_get('@@permitted_params')

      class_variable_set('@@permitted_params',
        permitted_params << {images_attributes: Image.permitted_params})
    end
  end


  def image_kinds
    self.class.image_kinds
  end
end
