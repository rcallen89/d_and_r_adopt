class PetAdoptForm < ApplicationRecord
  belongs_to :pet
  belongs_to :adopt_form
end