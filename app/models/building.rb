class Building < ApplicationRecord
  validates :address, presence: true
  validates :coordinates, presence: true

  attr_writer :longitude, :latitude

  delegate :longitude, :latitude, to: :coordinates
end
