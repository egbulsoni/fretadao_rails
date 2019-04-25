#!/bin/ruby
require 'httparty'
require 'nokogiri'
require 'byebug'
require 'tinyurl'

module Scraper
  def self.scrape(page_query)
    url = 'https://twitter.com' + page_query
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    profile_pic = parsed_page.css('img.ProfileAvatar-image').attribute('src')
    profile_nickname = parsed_page.css('h2.ProfileHeaderCard-screenname.u-inlineBlock.u-dir')
    profile_url = parsed_page.css('p.ProfileHeaderCard-bio.u-dir')

    # return a hash (dictionary) with profile info
    profile = {
      img: "#{TinyUrl.make_request profile_pic.text}",
      username: profile_nickname.text.strip.gsub('\n', ''),
      url: "#{TinyUrl.make_request url}"
    }
    # byebug
  end
end

# puts('input the twitter profile url, i.e: /usefretadao')
# page = gets.chomp
# puts Scraper.scrape(page)
