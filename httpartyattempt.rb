# require 'awesome_print'


# dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
# require 'pp'
# require 'httparty'


# class Reddit
#   include HTTParty
#   base_uri "http://www.reddit.com"
#   def initialize(subreddit, title)
#     @subreddit = subreddit
#     @title = title
#   end

#   def get_subreddit
#     self.class.get("/r/#{@subreddit}.json")
#   end

#   def get_comments
#     response = JSON.parse(self.get_subreddit.to_json)
#     @ids = []
#     response['data']['children'].each do |post|
#       if post['data']['title'].include? @title
#         @ids << post['data']['id']
#       end
#     end
#     ap @ids
#   end

#   def login(username, password)
#     options = {:user => username, :passwd => password}
#     self.class.post("/api/login/#{username}", options)
#   end

#   def post_reply
#     options = {:api_type => "json",:text => "TESTTTT!!!!!", :thing_id => @ids.first}
#     if get_comments
#       self.class.post("/api/comment/#{@ids.first}", options)
#     end
#   end

#   # def logged_in?
#   #   ap self.class.get("/api/v1/me")
#   # end

# end

# a = Reddit.new("dbctest", "dbctestpost")
# a.login("dbcbot", "dbcbot1")
# a.get_comments
# a.post_reply
# # x = Reddit.new
# # x.login('dbcbot', 'dbcbot1')
# # response = x.get_subreddit("DBCTest")
# # parsed = JSON.parse(response.to_json)
# # ids = []
# # parsed['data']['children'].each do |thingy|
# #   if thingy['data']['title'].include? "dbctestpost"
# #     ids << thingy['data']['id']
# #   end
# # end

# # ap ids
