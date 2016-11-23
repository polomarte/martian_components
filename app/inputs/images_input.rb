class ImagesInput
  include ::Formtastic::Inputs::Base

  def to_html
    images = object.image_kinds.map do |image_kind|
      object.public_send(image_kind) || object.images.build(kind: image_kind)
    end

    builder.semantic_fields_for :images, images do |img_form|
      inputs_label = object.class.human_attribute_name(img_form.object.kind) rescue nil

      img_form.inputs inputs_label, class: 'inputs media-uploader-inputs' do
        t = img_form.template

        li_css_classes = 'fileinput-button file input required'

        t.output_buffer << t.content_tag(:li, class: li_css_classes) do
          output = ''
          output << img_form.s3_file_field(:file)
          output << t.content_tag(:p, img_form.object.decorate.form_hint, class: 'inline-hints')
          output << Nokogiri::HTML.fragment(
            img_form.input :remote_file_url, as: :hidden).css('input').to_s.html_safe

          if img_form.object.persisted?
            output << t.link_to('Remover', '#', class: 'remove-media-btn')
            output << Nokogiri::HTML.fragment(
              img_form.input(:_destroy, as: :hidden)).css('input').to_s.html_safe
          end

          output.html_safe
        end

        img_form.input :kind, as: :hidden
        img_form.input :imageable_id, as: :hidden
        img_form.input :imageable_type, as: :hidden
      end
    end
  end
end
