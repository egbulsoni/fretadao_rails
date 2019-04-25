class ProfilesController < ApplicationController
  include Scraper
  def index
    @profiles = Profile.all
  end
  def create
    @values = Scraper.scrape(params[:twitter])
    @profile = Profile.new({:name => params[:name],
      :url => @values[:url], :username => @values[:username],
      :image => @values[:img]})
  end
  def show
    @profile = Profile.find(params[:id])
  end
  def search

  end
end
