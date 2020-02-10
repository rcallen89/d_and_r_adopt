class Pet < ApplicationRecord
  validates_presence_of :name, :description, :approximate_age, :sex

  belongs_to :shelter
  has_many :pet_adopt_forms, dependent: :destroy 
  has_many :adopt_forms, through: :pet_adopt_forms

  enum adoptable: %w(Available Pending Adopted)

  def pending_form
    AdoptForm.find(self.pending_app).name
  end

end
