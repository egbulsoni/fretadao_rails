#!/bin/ruby
require 'httparty'
require 'nokogiri'
require 'byebug'
# require 'tiny_url'
require "shorturl"

module Scraper
  def self.scrape(page_query)
    url = 'https://twitter.com' + page_query
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    profile_pic = parsed_page.css('img.ProfileAvatar-image').attribute('src')
    profile_nickname = parsed_page.css('h2.ProfileHeaderCard-screenname.u-inlineBlock.u-dir')
    profile_desc = parsed_page.css('p.ProfileHeaderCard-bio.u-dir')

    # return a hash (dictionary) with profile info
    profile = {
      # img: "#{TinyUrl.make_request profile_pic.text}",
      img: "#{ShortURL.shorten("#{profile_pic}")}",
      username: profile_nickname.text.strip.gsub('\n', ''),
      # url: "#{TinyUrl.make_request url}"
      url: "#{ShortURL.shorten("#{url}")}",
      desc: "#{profile_desc.text.strip}"
    }
  end
end

# p ShortURL.valid_services
# puts('input the twitter profile url, i.e: /usefretadao')
# page = gets.chomp
# puts Scraper.scrape(page)
