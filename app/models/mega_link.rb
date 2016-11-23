class MegaLink < Component
  store_accessor :data, :link_url
  validates :link_url, presence: true, if: ->(r) { r.file.blank? }

  mount_uploader :file, FileUploader

  define_image_kinds [:image, :icon]

  def self.permitted_params
    super | [:link_url, :file, :file_cache]
  end
end
