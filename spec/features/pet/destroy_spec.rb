require 'rails_helper'

RSpec.describe 'As a visitor to a pets show page', type: :feature do
  before(:each) do
    @shelter1 = Shelter.create!(name: "Joe's Shelter", address: "123 Main St.", city: "Dallas", state: "TX", zip: "75341")

    @pet1 = @shelter1.pets.create!(name: "Tron",
                       image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002248/GettyImages-187066830.jpg",
                       approximate_age: 3,
                       sex: "Male",
                       description: 'Too Cool for School')
  end

  it 'should delete pet' do
    visit "/pets"

    expect(page).to have_content("Tron")

    visit "/pets/#{@pet1.id}"

    click_on "Delete Pet"

    expect(current_path).to eq("/pets")

    expect(page).to_not have_content("Tron")
  end
end