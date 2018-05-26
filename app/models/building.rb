class Building < ApplicationRecord
  validates :address, presence: true
  validates :coordinates, presence: true
end
