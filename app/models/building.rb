class Building < ApplicationRecord
  before_validation :set_coordinates, unless: :coordinates

  validates :address, presence: true
  validates :coordinates, presence: true

  attr_writer :longitude, :latitude

  delegate :longitude, :latitude, to: :coordinates

  private

  def set_coordinates
    self.coordinates = "POINT(#{@longitude} #{@latitude})"
  end
end
