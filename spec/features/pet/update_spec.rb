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

  it 'should update a pets information' do
    visit "/pets/#{@pet1.id}"

    expect(page).to have_content(@pet1.name)
    expect(page).to have_css("img[src*='#{@pet1.image}']")
    expect(page).to have_content(@pet1.approximate_age)
    expect(page).to have_content(@pet1.sex)

    click_on "Update Pet"

    expect(current_path).to eq("/pets/#{@pet1.id}/edit")

    fill_in :name, with: "Kat"
    fill_in :approximate_age, with: 4
    fill_in :sex, with: "female"
    fill_in :description, with: "Too Hot for TV"

    click_on "Update Pet"

    expect(current_path).to eq("/pets/#{@pet1.id}")

    expect(page).to have_content("Kat")
    expect(page).to have_css("img[src*='#{@pet1.image}']")
    expect(page).to have_content(4)
    expect(page).to have_content("female")
    expect(page).to have_content("Too Hot for TV")


    expect(page).to_not have_content("Tron")
    expect(page).to_not have_content(3)
    expect(page).to_not have_content("Male")
    expect(page).to_not have_content("Too Cool for School")
  end
end