require 'redditkit'
require 'nokogiri'
require 'open-uri'


class Reddit
  def sign_in_public
    @client = RedditKit::Client.new 'soupb', 'dbcbot1'
  end

  def get_list
    @doc = Nokogiri::HTML(open("https://nvd.nist.gov/download/nvd-rss-analyzed.xml"))
    @links = @doc.xpath("//items/seq")
    @cves = @doc.xpath("//item")
  end

  def post_cve
    # @cves.each_with_index do |cve, index|
    #   title =  cves[index].children[1].content
    #   # link = cves[index].children[4] ## this is including a "&#13;" at the end, it still works but we need to get rid of it
    #   # description = cves[index].children.children
    #   body = cves[index].children.children[1].content + " " + cves[index].children[4].content
    #   client.submit(title, "cvewatch", options = {:text => body})
    #   #needs logic to check to see if it's already been posted
    # end
    title = @cves[0].children[1].content
    body = @cves[0].children.children[1].content + " " + @cves[0].children[4].content
    @client.submit(title, "cvewatch", options = {:text => body})
  end


end

reddit = Reddit.new
reddit.sign_in_public
reddit.get_list
reddit.post_cve
