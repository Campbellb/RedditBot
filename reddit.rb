require 'redditkit'
require 'nokogiri'
require 'open-uri'
require 'awesome_print'
require 'httparty'



class Reddit
  include HTTParty
  base_uri "http://www.reddit.com"

  def get_subreddit
    self.class.get("/r/cvewatch.json")
  end

  def check
    response = JSON.parse(self.get_subreddit.to_json)
    titles = []
    response['data']['children'].each do |post|
      titles << post['data']['title']
    end
    self.get_list
    self.find_recent
    self.post_cve unless titles.include? @title
  end

  def sign_in
    @client = RedditKit::Client.new 'soupb', '****'
  end

  def get_list
    @doc = Nokogiri::HTML(open("https://nvd.nist.gov/download/nvd-rss-analyzed.xml"))
    @cves = @doc.xpath("//item")
  end

  def find_recent
    @title = @cves[0].children[1].content
    @body = @cves[0].children.children[1].content + " " + @cves[0].children[4].content
  end

  def post_cve
     @client.submit(@title, "cvewatch", options = {:text => @body})
  end


end

reddit = Reddit.new
if reddit.signed_in? == true
  reddit.check
else
  reddit.sign_in
  reddit.check
end
