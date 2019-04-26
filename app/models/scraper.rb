#!/bin/ruby
require 'httparty'
require 'nokogiri'
require 'byebug'
# require 'tiny_url'
require "shorturl"

module Scraper
  def self.scrape(page_query)
    twitter = "https://twitter.com/"
    url = page_query if page_query.starts_with?(twitter)
    url = RedirectFollower.new("#{page_query}").url unless page_query.starts_with?(twitter)
    # url = HTTParty.get(page_query) if page_query[0,19] = "https://tinyurl.com"
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

# ShortURL.valid_services
# puts('input the twitter profile url, i.e: /usefretadao')
# page = gets.chomp
# puts Scraper.scrape(page)
