class HoverItem < Component
  define_image_kinds [:icon, :background]

  def video_id
    return nil if link_url.blank?
    uri = URI.parse(link_url)
    return nil if uri.relative?
    return nil if !uri.host.include?('youtube')

    CGI.parse(uri.query)['v'][0]
  end

  def options
    options = super
    options[:modal] = true if video_id.present?
    options
  end
end
