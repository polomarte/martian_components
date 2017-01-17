class ImagesInput
  include ::Formtastic::Inputs::Base

  def to_html
    builder.semantic_fields_for :images, images do |img_form|
      @img_form = img_form
      img_form_inputs
    end
  end

  private

  def img_form
    @img_form
  end

  def images
    object.image_kinds.map do |image_kind|
      object.public_send(image_kind) || object.images.build(kind: image_kind)
    end
  end

  def img_form_inputs
    img_form.inputs img_form_inputs_label, class: 'inputs media-uploader-inputs' do
      output = ''

      output << template.content_tag(:li, class: 'fileinput-button file input required') do
        out = ''
        out << img_form.s3_file_field(:file)
        out << template.content_tag(:p, img_form.object.decorate.form_hint, class: 'inline-hints')
        out << img_form.hidden_field(:remote_file_url)

        if img_form.object.persisted?
          out << template.link_to('Remover', '#', class: 'remove-media-btn')
          out << img_form.hidden_field(:_destroy)
        end

        out.html_safe
      end

      output << img_form.input(:kind, as: :hidden)
      output << img_form.input(:imageable_id, as: :hidden)
      output << img_form.input(:imageable_type, as: :hidden)

      output.html_safe
    end
  end

  def img_form_inputs_label
    object.class.human_attribute_name(img_form.object.kind) rescue nil
  end
end
