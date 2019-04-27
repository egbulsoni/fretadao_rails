# frozen_string_literal: true

require 'httparty'
require 'nokogiri'
require 'byebug'
# require 'tiny_url'
require 'shorturl'

module Scraper
  def self.scrape(page_query)
    twitter = 'https://twitter.com/'
    url = page_query if page_query.starts_with?(twitter)
    url = RedirectFollower.new(page_query.to_s).url unless page_query.starts_with?(twitter)
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    profile_pic = parsed_page.css('img.ProfileAvatar-image').attribute('src')
    profile_nickname = parsed_page.css('h2.ProfileHeaderCard-screenname.u-inlineBlock.u-dir')
    profile_desc = parsed_page.css('p.ProfileHeaderCard-bio.u-dir')

    # return a hash (dictionary) with profile info
    {
      img: ShortURL.shorten(profile_pic.to_s).to_s,
      username: profile_nickname.text.strip.gsub('\n', ''),
      url: ShortURL.shorten(url.to_s).to_s,
      desc: profile_desc.text.strip.to_s
    }
  end
end

# ShortURL.valid_services
# puts('input the twitter profile url, i.e: /usefretadao')
# page = gets.chomp
# puts Scraper.scrape(page)
