require 'awesome_print'


dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'pp'
require 'httparty'

class Reddit
  include HTTParty
  base_uri "https://www.reddit.com/r"

  def get_subreddit(subreddit)
    self.class.get("/#{subreddit}.json")
  end

  def login(username, password)
    options = {:body => {:user => username, :passwd => password, :api_type => 'json'}}
    self.class.post("/api/login/#{username}", options)
  end

  def post_reply
  end
end

x = Reddit.new
x.login('dbcbot', 'dbcbot1')
response = x.get_subreddit("DBCTest")
parsed = JSON.parse(response.to_json)
ids = []
parsed['data']['children'].each do |thingy|
  if thingy['data']['title'].include? "dbctestpost"
    ids << thingy['data']['id']
  end
end

ap ids
