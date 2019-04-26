class ProfilesController < ApplicationController
  include Scraper
  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end

  def create
    @values = Scraper.scrape(allowed_params[:url])
    @profile = Profile.create({:name => allowed_params[:name],
      :image => @values[:img], :username => @values[:username],
      :url => @values[:url], :desc => @values[:desc]})
    @profile.save
    redirect_to root_path
    # byebug

  end
  def show
    @profile = Profile.find(params[:id])
  end

  def search
  end

  private

    def allowed_params
      params.require(:profile).permit(:name, :url)
    end
end
