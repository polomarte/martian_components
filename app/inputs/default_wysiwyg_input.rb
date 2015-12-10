class DefaultWysiwygInput < Formtastic::Inputs::Wysihtml5Input
  def input_html_options
    super.merge({
      id:       "default_wysiwyg_input_#{SecureRandom.urlsafe_base64(4)}",
      commands: [:bold, :italic, :underline, :ul, :ol, :link, :source],
      blocks:   :barebone})
  end
end
