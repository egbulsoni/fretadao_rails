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

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @values = Scraper.scrape(edit_params[:url])
    @profile = Profile.find(params[:id])
    @profile.update({name: edit_params[:name],
                    image: @values[:img], username: edit_params[:username],
                    url: @values[:url], desc: edit_params[:desc]})

    redirect_to profile_path(@profile)
  end

  def destroy
    @profile = Profile.find(params[:id]).destroy
    redirect_to root_path
  end

  def search
  end

  private

    def edit_params
      params.require(:profile).permit(:name, :url, :image, :username, :desc)
    end

    def allowed_params
      params.require(:profile).permit(:name, :url)
    end
end
