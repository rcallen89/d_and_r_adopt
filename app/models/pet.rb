class Pet < ApplicationRecord
  validates_presence_of :name, :description, :approximate_age, :sex

  belongs_to :shelter

  enum adoptable: %w(Yes Pending No)
end
