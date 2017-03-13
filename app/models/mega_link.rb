class MegaLink < Component
  validates :link_url, presence: true, if: ->(r) { r.file.blank? }

  mount_uploader :file, FileUploader

  define_image_kinds [:image, :icon]

  def self.permitted_params
    super | [:file, :file_cache]
  end
end
