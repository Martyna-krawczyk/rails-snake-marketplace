class Listing < ApplicationRecord
  
  belongs_to :breed
  has_many :listings_traits
  has_many :traits, through: :listings_traits
  belongs_to :user

  enum sex: { female: 0, male: 1 }

  validates :title, :sex, :price, :breed, :city, :diet, presence: true

  validates :description, presence: true, length: { minimum: 10 }

  validates :price, numericality: true

  validates :deposit,numericality: true 
  
  validates_numericality_of :deposit, :less_than_or_equal_to => :price

  validates :state, inclusion: { in: %w(VIC NSW WA NT ACT QLD SA TAS), message: "%{value} is not a valid state" }

  has_one_attached :picture
  
end
