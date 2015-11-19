class MegaLinkDecorator < ComponentDecorator
  def link
    if object.link_url.present?
      options = object.options[:html_options].try :merge, {
        remote: link_is_remote?
      }

      link_to link_url, options do
        yield
      end
    else
      link_to object.file_url, target: '_blank' do
        yield
      end
    end
  end

  def icon
    super(object.icon.try(:file_url) || image_path('icons/download.svg'))
  end

private

  def link_is_remote?
    !!(object.link_url =~ /\.(js|json)$/)
  end
end
