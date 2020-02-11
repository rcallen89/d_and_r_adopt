require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe 'relationships' do
    it {should have_many :pets}
    it {should have_many :reviews}
  end

  describe 'methods' do
    before(:each) do 
      @shelter1 = create(:shelter)
      @pet1 = @shelter1.pets.create!(name: "Tron",
                            image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002248/GettyImages-187066830.jpg",
                            approximate_age: 3,
                            sex: "Male",
                            description: 'Too Cool for School')
    end
    it 'calcualte number of pets with num_pets' do
      
      expect(@shelter1.num_pets).to eq(1)
      pet2 = @shelter1.pets.create!(name: "Kat",
                  image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002248/GettyImages-187066830.jpg",
                  approximate_age: 2,
                  sex: "Female",
                  description: 'Too Hot for TV')
      expect(@shelter1.num_pets).to eq(2)
    end

    it 'calculates average review score with avg_score' do 
      review1 = create(:review, shelter: @shelter1)
      review2 = create(:review, title: "Shelter 2 Review", rating: 2, shelter: @shelter1)

      expect(@shelter1.avg_score).to eq(3)
    end

    it 'calcualte number of pets with num_apps' do
      shelter2 = create(:shelter)
      pet2 = create(:pet, shelter: @shelter1)
      pet3 = create(:pet, shelter: shelter2)

      adopt_form1 = create(:adopt_form)
      create(:pet_adopt_form, adopt_form: adopt_form1, pet: @pet1)
      expect(@shelter1.num_apps).to eq(1)

      adopt_form2 = create(:adopt_form)
      create(:pet_adopt_form, adopt_form: adopt_form2, pet: @pet1)
      expect(@shelter1.num_apps).to eq(2)

      adopt_form3 = create(:adopt_form)
      create(:pet_adopt_form, adopt_form: adopt_form3, pet: pet2)
      expect(@shelter1.num_apps).to eq(3)

      adopt_form4 = create(:adopt_form)
      create(:pet_adopt_form, adopt_form: adopt_form4, pet: pet3)
      expect(@shelter1.num_apps).to eq(3)
    end
  end
end
