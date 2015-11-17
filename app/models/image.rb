class Image < ActiveRecord::Base
  translates :title, :description
  mount_uploader :file, ImageUploader

  belongs_to :imageable, polymorphic: true
  validates :file, presence: true
  validates :title, presence: true, if: :photo?
  before_save :position_fallback

  scope :active, ->{ where(active: true) }

  def self.permitted_params
    [:id, :description, :date,
     :active, :kind, :file, :file_cache, :remote_file_url,
     :imageable_id, :imageable_type, :position, :_destroy]
  end

  def to_result_search_partial_path
    "images/result_search"
  end

  def self.policy_class
    ApplicationPolicy
  end

protected

  # Caso as imagens nunca tenham sido reordenadas, :position não deve ficar nil
  def position_fallback
    if imageable.present? && imageable.respond_to?(:images)
      self.position = imageable.images.index(self) if position.nil?
    end
  end

  def photo?
    kind == 'photo'
  end
end
