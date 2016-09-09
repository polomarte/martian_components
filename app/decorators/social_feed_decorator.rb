class SocialFeedDecorator < ComponentDecorator
  def published_at
    datetime_diff = DateTime.now.utc.to_i - object.published_at.to_datetime.to_i
    diff_in_minutes = (datetime_diff / 1.minute).minutes
    time_ago_in_words(diff_in_minutes.ago)
  end
end
