class ImageDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def form_hint
    output = ''

    image_url = if file = object.file.try(:file).try(:exists?) && object.file
      file.svg? ? file.url : (file.try(:thumb).try(:url) || file.url)
    end

    output << image_tag(image_url)

    output << <<-HTML
      <span class='placeholder'>
        Arraste ou clique aqui para adicionar uma imagem
      </span>
    HTML

    output.html_safe
  end
end
