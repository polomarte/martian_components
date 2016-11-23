class VideoInput
  include ::Formtastic::Inputs::Base

  def to_html
    li_css_classes = 'fileinput-button file input required'

    template.content_tag(:li, class: li_css_classes) do
      output = ''
      output << label_html
      output << builder.s3_file_field(method)
      output << template.content_tag(:p, hint, class: 'inline-hints')
      output << template.hidden_field_tag("component[remote_#{method}_url]", object.send("remote_#{method}_url"))

      if object.send(method).present?
        output << template.link_to('Remover', '#', class: 'remove-media-btn')
        output << template.hidden_field_tag("component[remove_#{method}]", object.send("remove_#{method}"))
      end

      output.html_safe
    end
  end

  def hint
    output = ''

    output << template.video_tag(object.send("#{method}_url"))

    output << <<-HTML
      <span class='placeholder'>
        Arraste ou clique aqui para adicionar um video
      </span>
    HTML

    output.html_safe
  end
end
