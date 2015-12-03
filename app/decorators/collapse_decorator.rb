class CollapseDecorator < ComponentDecorator
  def media html=nil
    output =
      if object.nested_component
        render object.nested_component
      elsif object.image.present?
        image_tag(object.image.file_url)
      elsif html
        html
      end

    content_tag :div, output, class: 'media-wrapper' if output.present?
  end
end
