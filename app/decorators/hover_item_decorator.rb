class HoverItemDecorator < ComponentDecorator
  def show_modal?
    object.options[:modal] || object.video_id.present?
  end
end
