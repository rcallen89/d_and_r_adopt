class AdoptForm < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone_number, :description


  has_many :pet_adopt_forms
  has_many :pets, through: :pet_adopt_forms

end