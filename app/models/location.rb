class Location < ApplicationRecord
  validates_presence_of :city, :quantity
  belongs_to :job
end
