class ComponentDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def title
    object.title.presence || object.h1
  end

  def h1
    return unless object.h1.present? && !object.options[:h1_disabled]
    content_tag :h1, object.h1
  end

  def h2
    return unless object.h2.present?
    content_tag :h2, object.h2
  end

  def text
    return unless object.text.present?
    content_tag :div, object.text.html_safe, class: 'text'
  end

  def image
    return unless object.image.present?

    css_classes = [
      object.image.kind.parameterize('-'),
      object.options[:main_image_position]
    ].join(' ')

    image_tag object.image.file_url, class: css_classes
  end

  def icon_image
    return unless object.icon_image.present?

    file = object.icon_image.file

    content_tag :div, class: 'icon-wrapper' do
      if file.svg?
        content_tag :div, nil, 'data-lazy-svg-url' => file.url
      else
        image_tag(file.url)
      end
    end
  end

  def background_image
    return unless object.background_image.present?

    content_tag :div, class: 'background-image-wrapper', data: {liquid_fill: true} do
      image_tag object.background_image.file_url
    end
  end
end
