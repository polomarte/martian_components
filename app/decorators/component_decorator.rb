class ComponentDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def title
    object.title.presence || object.h1
  end

  def h1
    return unless object.h1.present? && !object.options[:h1_disabled]
    content_tag :h1, object.h1.html_safe, class: object.options[:h1_class]
  end

  def h2
    return unless object.h2.present?
    content_tag :h2, object.h2.html_safe
  end

  def text
    return unless object.text.present?
    content_tag :div, object.text.html_safe, class: "text #{object.options[:text_class]}"
  end

  def image
    return unless object.try(:image).present?

    css_classes = [
      object.image.try(:kind).try(:parameterize, '-'),
      object.options[:image_class]
    ].join(' ')

    image_tag object.image_url, class: css_classes
  end

  def icon icon_path=nil
    icon_path = icon_path || object.try(:icon) && object.icon_url
    return unless icon_path.present?

    h.content_tag :div, class: 'icon-wrapper' do
      h.content_tag :div, class: 'icon-wrapper-inner' do
        if icon_path.ends_with?('.svg')
          h.content_tag :div, nil, 'data-lazy-svg-url' => icon_path
        else
          image_tag(icon_path)
        end
      end
    end
  end

  def background background_path=nil
    background_path = background_path || object.try(:background) && object.background_url
    return unless background_path.present?
    content_tag :div, '', class: 'background-image-wrapper', style: "background-image: url(#{background_path})"
  end

  def link_btn
    return unless link_label.present? && link_url.present?

    css_classes = ['link-btn', 'btn', options[:link_btn_class]].join(' ')

    link_to link_label, link_url, target: link_url_target_attr, class: css_classes
  end

  def link_url_target_attr
    link_url_host = URI.parse(link_url).host rescue nil

    if link_url.start_with?('/') || link_url_host == ENV['HOST']
      '_self'
    else
      '_blank'
    end
  end

  # Form specific methods

  def form_disabled_attrs
    object.form_options[:disabled_attrs] || []
  end

  def form_additional_editable_attrs
    object.form_options[:additional_editable_attrs] || []
  end
end
