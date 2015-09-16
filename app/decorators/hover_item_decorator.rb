class HoverItemDecorator < ComponentDecorator
  def show_modal?
    object.options[:modal] || object.video_id.present?
  end

  def link_url_target_attr
    URI.parse(link_url).host == ENV['HOST'] ? '_self' : '_blank'
  end
end
