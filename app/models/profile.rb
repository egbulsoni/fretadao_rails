class Profile < ApplicationRecord
  # require 'filterrific'
  # filterrific(
  #   default_filter_params: { search_query: ''},
  #   available_filters: [ :search_query ]
  # )
  #
  # scope :search_query, -> { where(':name LIKE :search_query',
  #   {name: Profile.name, search_query: params[:search_query]}) }

  def self.search(search)
    if search
      profile = Profile.where('name LIKE ? OR username LIKE ? OR desc LIKE ?', 
        "%#{search}%", "%#{search}%", "%#{search}%")

      #Profile.find_by(name: search)
      if profile
        self.where(id: profile)
      else
        Profile.all
      end
    else
      Profile.all
    end
  end

end
