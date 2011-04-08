require 'rubygems'
require 'linkedin'

# get your api keys at https://www.linkedin.com/secure/developer
client = LinkedIn::Client.new('s2G6xce6bVU8VWPg9EzuxdqI2fOdt_UzdFT3Be4dWOzBhd5pLeV-dHSGdDgihUFC', 'jGBodIArZhwt-lasTM1EyFj1rIg2UmJe13pqUd6a-RsScdRAEkunXggjSMc_frMX')
rtoken = client.request_token.token
rsecret = client.request_token.secret

# to test from your desktop, open the following url in your browser
# and record the pin it gives you
client.request_token.authorize_url
=> "https://api.linkedin.com/uas/oauth/authorize?oauth_token=<generated_token>"

# then fetch your access keys
client.authorize_from_request(rtoken, rsecret, pin)
=> ["OU812", "8675309"] # <= save these for future requests

# or authorize from previously fetched access keys
client.authorize_from_access("OU812", "8675309")

# you're now free to move about the cabin, call any API method

client.profile(:url => 'http://www.linkedin.com/in/shoaibrahman', :fields => %w(first-name, last-name, headline, related-connections)
