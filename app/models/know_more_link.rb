class KnowMoreLink < Component
  store_accessor :data, :link_url

  def self.permitted_params
    super | [:link_url]
  end

  def link_url_target_attr
  	URI.parse(link_url).host == ENV['HOST'] ? '_self' : '_blank'
  end

end
