# frozen_string_literal: true

class Profile < ApplicationRecord
  # validates :name, :url, presence: true
  # validates :url, uniqueness: true
  # validates :url, format: { with: /@.{1,}/}

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

  # private
  #
  #   def process_xor_url
  #     unless charge.match()
  #       errors.add(:base, "Specify a charge or a payment, not both")
  #     end
  #   end
  # scope :verify, ->(id) {Profile.find(id)}
end
