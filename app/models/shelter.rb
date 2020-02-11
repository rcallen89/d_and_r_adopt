class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :pets
  has_many :reviews

  def num_pets
    pets.count
  end

  def avg_score
   reviews.average(:rating)
  end

  def num_apps
    pets.joins(:pet_adopt_forms).count
  end
end
