class TwitterService
  attr_reader :client

  def initialize(user)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["twitter_consumer_key"]
      config.consumer_secret = ENV["twitter_consumer_secret"]
      config.access_token = 	user.oauth_token
      config.access_token_secret = user.oauth_token_secret
    end
  end

  def tweet(content)
    client.update(content, options={})
  end
end
