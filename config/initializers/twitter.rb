
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "8x5wY37A5vQUjwtjhYWXFtiZD", "0ERUe8uHBh5SLT5IdlkogKbxcfjSCsUAHAlF5qLFHxbdoCAntX"
end

# twitter = Twitter::REST::Client.new do |config|
#   config.consumer_key = "8x5wY37A5vQUjwtjhYWXFtiZD"
#   config.consumer_secret = "0ERUe8uHBh5SLT5IdlkogKbxcfjSCsUAHAlF5qLFHxbdoCAntX"
#   config.access_token = 	"557354944-ep6qzUu6uowkVZgl9Qm2b37pnmTVhQudPhl1TBz1"
#   config.access_token_secret = "jw1r9Etj9sUDatiBRQLVgRm4GdxoJWXnLhqyeFnhekcm8"
# end
