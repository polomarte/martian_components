class CollapseDecorator < ComponentDecorator
  def media html=nil
    output =
      if object.try(:nested_component)
        render object.nested_component
      elsif object.try(:file).present?
        render 'components/collapse/file', collapse: object
      elsif object.try(:video_code).present?
        embedded_video_player object.video_code
      elsif object.try(:image).present?
        image_tag object.image_url(:small)
      elsif object.try(:media_html).present?
        object.media_html
      elsif html
        html
      end

    css_classes = ['media-wrapper']
    css_classes << 'file' if object.try(:file).present?

    content_tag :div, output, class: css_classes.join(' ') if output.present?
  end

  def text for_modal: false
    if object.text_with_manual_division? && !for_modal
      output = ''
      splitted_text = object.text.split(Collapse::TEXT_SPLITTER)
      output << content_tag(:div, splitted_text.first.html_safe, class: "text #{object.options[:text_class]}")
      output << content_tag(:div, '', class: 'clearfix')
      output << content_tag(:div, splitted_text.last.html_safe, class: "text collapse #{object.options[:text_class]}")
      output.html_safe
    else
      object.text.sub!(Collapse::TEXT_SPLITTER, '')
      super()
    end
  end
end
