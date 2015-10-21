# Before use this service, check if PERMANENT_FANPAGE_TOKEN env var exists.
# Run `rake get_permanent_fanpage_token` to get one.

class FetchFacebookPageFeedsService
  def self.perform *args
    new.perform *args
  end

  def self.get_permanent_fanpage_token *args
    new.get_permanent_fanpage_token(*args)
  end

  def perform fanpage_id, token:
    @api = Koala::Facebook::API.new(token)

    feed_fields = ['message', 'full_picture', 'link', 'created_time', 'id', 'type']
    @api.get_connections(fanpage_id, 'feed', {fields: feed_fields})
  end

  def get_permanent_fanpage_token fanpage_id
    oauth = Koala::Facebook::OAuth.new(ENV['FB_APP_ID'], ENV['FB_APP_SECRET'], ENV['FB_CALLBACK_URL'])

    puts 'Copie a URL e cole no navegador. Após redirecionamento, copie o código da nova URL e cole aqui:'
    puts oauth.url_for_oauth_code(permissions: 'manage_pages')

    code = STDIN.gets.chomp

    token = oauth.get_access_token(code)
    puts "\nToken token:"
    puts token

    puts "\nExchanged_token:"
    exchanged_token = oauth.exchange_access_token(token)
    puts exchanged_token

    puts "\nPermanent token:"
    puts Koala::Facebook::API.new(exchanged_token).get_page_access_token(fanpage_id)
  end
end
