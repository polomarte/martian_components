class MegaLinkDecorator < ComponentDecorator
  def link
    if object.link_url.present?
      link_to link_url, target: '_blank', remote: link_is_remote? do
        yield
      end
    else
      link_to object.file_url, target: '_blank' do
        yield
      end
    end
  end

private

  def link_is_remote?
    !!(object.link_url =~ /\.(js|json)$/)
  end
end
