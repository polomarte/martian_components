class Collapse < Component
  TEXT_SPLITTER = '[[more]]'.freeze

  store_accessor :data, :nested_component_key, :file_caption, :video_code
  mount_uploader :file, FileUploader

  define_image_kinds [:image]

  before_validation :parse_video_code

  def self.permitted_params
    super | [:file, :file_cache, :file_caption, :remove_file, :video_code]
  end

  def nested_component
    if nested_component_key
      Component[nested_component_key]
    end
  end

  def text_with_manual_division?
    text[TEXT_SPLITTER].present?
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

