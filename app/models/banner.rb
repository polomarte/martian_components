class Banner < Component
  mount_uploader :video_mp4, VideoUploader
  mount_uploader :video_ogg, VideoUploader

  define_image_kinds [:icon, :background]

  validates :background, presence: true, if: ->{video_mp4.present? || video_ogg.present?}
  validates :video_mp4, presence: true, if: ->{video_ogg.present? && remove_video_ogg.blank?}
  validates :video_ogg, presence: true, if: ->{video_mp4.present? && remove_video_mp4.blank?}
  validate :videos_mime_types_validation, if: ->{video_mp4.present? && video_ogg.present?}

  before_validation :fix_videos_mime_types, if: ->{video_mp4.present? && video_ogg.present?}

  def self.permitted_params
    @@permitted_params | [:remote_video_mp4_url, :remove_video_mp4, :remote_video_ogg_url, :remove_video_ogg]
  end

private

  def videos_mime_types_validation
    if 'video/mp4' != video_mp4.content_type
      errors.add(:video_mp4, :invalid_mime)
    end

    unless ['video/ogg', 'video/ogv'].include? video_ogg.content_type
      errors.add(:video_ogg, :invalid_mime)
    end
  end

  def fix_videos_mime_types
    if video_mp4.content_type == 'application/mp4'
      video_mp4.file.content_type = 'video/mp4'
    end
  end
end
