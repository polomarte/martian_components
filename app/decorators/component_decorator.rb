class ComponentDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def title
    object.title.presence || object.h1
  end

  def h1
    return unless object.h1.present? && !object.options[:h1_disabled]
    content_tag :h1, object.h1, class: object.options[:h1_class]
  end

  def h2
    return unless object.h2.present?
    content_tag :h2, object.h2
  end

  def text
    return unless object.text.present?
    content_tag :div, object.text.html_safe, class: "text #{object.options[:text_class]}"
  end

  def image
    return unless object.image.present?

    css_classes = [
      object.image.kind.parameterize('-'),
      object.options[:main_image_position]
    ].join(' ')

    image_tag object.image_url, class: css_classes
  end

  def icon icon_path=nil
    if object.icon.nil?
      return if icon_path.nil?
    else
      icon_path = object.icon_url
    end

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

  def background
    return unless object.background.present?

    image_file_url =
      if object.background.is_a? String
        object.background
      else
        object.background.file_url
      end

    content_tag :div, class: 'background-image-wrapper', data: {liquid_fill: true} do
      image_tag image_file_url
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
