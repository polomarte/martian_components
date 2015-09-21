namespace :martian_components do
  desc 'Permanent FB Page token generation process (options: fanpage_id=123456789)'
  task :get_permanent_fanpage_token => :environment do
    FetchFacebookPageFeedsService.get_permanent_fanpage_token ENV['fanpage_id']
  end
end
