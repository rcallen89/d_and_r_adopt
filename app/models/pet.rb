class Pet < ApplicationRecord
  validates_presence_of :name, :description, :approximate_age, :sex

  belongs_to :shelter
  has_many :pet_adopt_forms
  has_many :adopt_forms, through: :pet_adopt_forms

  enum adoptable: %w(Yes Pending No)
end
