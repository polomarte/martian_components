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
      template.concat file_input

      if builder.is_a? ActiveAdmin::FormBuilder
        img_form.input(:kind, as: :hidden)
        img_form.input(:imageable_id, as: :hidden)
        img_form.input(:imageable_type, as: :hidden)
      else
        template.concat img_form.input(:kind, as: :hidden)
        template.concat img_form.input(:imageable_id, as: :hidden)
        template.concat img_form.input(:imageable_type, as: :hidden)
      end
    end
  end

  def img_form_inputs_label
    object.class.human_attribute_name(img_form.object.kind) rescue nil
  end

  def file_input
    template.content_tag(:li, class: 'fileinput-button file input required') do
      output = ''

      output << img_form.s3_file_field(:file)
      output << template.content_tag(:p, img_form.object.decorate.form_hint, class: 'inline-hints')
      output << img_form.hidden_field(:remote_file_url)

      if img_form.object.persisted?
        output << template.link_to('Remover', '#', class: 'remove-media-btn')
        output << img_form.hidden_field(:_destroy)
      end

      output.html_safe
    end
  end
end
