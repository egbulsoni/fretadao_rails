# This module scraps a twitter profile, and gets its image, username
# and description. To use it, import the module, and call it.
# let 'url' be twitter.com/anything or https://twitter.com/anything.
# Scraper.scrape(url)
require 'httparty'
require 'nokogiri'
require 'byebug'
require 'shorturl'
require 'embiggen'

module Scraper
  def self.scrape(page_query)
    # expressions to check up
    start = 'https://'
    twitter = %r{twitter.com\/.{1,}}
    # constants to be scrapped
    img = 'img.ProfileAvatar-image'
    nick = 'h2.ProfileHeaderCard-screenname.u-inlineBlock.u-dir'
    desc = 'p.ProfileHeaderCard-bio.u-dir'

    # URL treatments
    url = ''
    url = start unless page_query.start_with?(start)
    url << page_query if page_query.match(twitter)
    url << "twitter.com/#{page_query[1..]}" if page_query.start_with?('@')
    if Embiggen::URI(page_query.to_s).shortened?
      url = Embiggen::URI(page_query.to_s).expand.to_s
    end
    # parsing and scraping
    unparsed_page = HTTParty.get(url)
    case unparsed_page.code
    when 404
      puts "error..."
      unparsed_page = HTTParty.get("https://twitter.com/unknown")
    when 500..600
      puts "error..."
      unparsed_page = HTTParty.get("https://twitter.com/unknown")
    end

    parsed_page = Nokogiri::HTML(unparsed_page)
    profile_pic = parsed_page.css(img).attribute('src')
    profile_nickname = parsed_page.css(nick)
    profile_desc = parsed_page.css(desc)

    # return a hash (dictionary) with profile info
    {
      img: ShortURL.shorten(profile_pic.to_s).to_s,
      username: profile_nickname.text.strip.gsub('\n', ''),
      url: ShortURL.shorten(url.to_s).to_s,
      desc: profile_desc.text.strip.to_s
    }
  end
end
