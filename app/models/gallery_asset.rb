class GalleryAsset < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader

  enum kind: [:video, :image, :file]

  belongs_to :gallery, touch: true

  validates :kind, :gallery, :position, presence: true
  validates :file, presence: true, if: 'kind == "file"'
  validates :image, presence: true, if: 'kind == "image"'
  validates :video_code, presence: true, if: 'kind == "video"'

  before_validation :parse_video_code

  scope :active, ->{ where(active: true) }

  def self.permitted_params
    [:id, :title, :description, :active, :kind, :gallery_id,
     :video_code, :position, :_destroy,
     :file, :file_cache, :remote_file_url,
     :image, :image_cache, :remote_image_url]
  end

  def self.policy_class
    ApplicationPolicy
  end

  def to_partial_path
    "components/gallery/asset"
  end

private

  def parse_video_code
    if video_code.present? && video_code.starts_with?('http')
      uri = URI.parse(video_code)

      if uri.host.include?('youtube')
        self.video_code = CGI.parse(uri.query)['v'][0]
      end
    end
  end
end
