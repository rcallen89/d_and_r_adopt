require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :approximate_age}
    it {should validate_presence_of :sex}
  end

  describe 'relationships' do
    it {should belong_to :shelter}
    it {should have_many :adopt_forms}
    it {should have_many(:adopt_forms).through(:pet_adopt_forms)}
  end
end
