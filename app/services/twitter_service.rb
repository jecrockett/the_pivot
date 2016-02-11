class TwitterService
  attr_reader :client

  def initialize(user)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "8x5wY37A5vQUjwtjhYWXFtiZD"
      config.consumer_secret = "0ERUe8uHBh5SLT5IdlkogKbxcfjSCsUAHAlF5qLFHxbdoCAntX"
      config.access_token = 	user.oauth_token
      config.access_token_secret = user.oauth_token_secret
    end
  end

  def tweet(content)
    client.update(content, options={})
  end
end
