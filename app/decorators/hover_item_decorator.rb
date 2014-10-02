class HoverItemDecorator < ComponentDecorator
  def text
    return unless object.text.present?
    output = ''
    output << content_tag(:div, object.text.html_safe, class: 'text')
    output << content_tag(:div, '+', class: 'more-icon')
    output.html_safe
  end
end
