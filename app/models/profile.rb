# frozen_string_literal: true

class Profile < ApplicationRecord
  def self.search(search)
    if search
      profile = Profile.where('name LIKE ? OR username LIKE ? OR desc LIKE ?',
                              "%#{search}%", "%#{search}%", "%#{search}%")
      # Profile.find_by(name: search)
      where(id: profile) if profile
    else
      Profile.all
    end
  end

  # scope :verify, ->(id) {Profile.find(id)}
end
