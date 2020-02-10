require 'rails_helper'

RSpec.describe 'As a visitor' do
  it 'should delete a shelter' do
    shelter1 = Shelter.create!(name: "Joe's Shelter", address: "123 Main St.", city: "Dallas", state: "TX", zip: "75341")
    shelter2 = Shelter.create!(name: "Jane's Shelter", address: "321 2nd St.", city: "Denver", state: "CO", zip: "80020")

    visit "/shelters/#{shelter1.id}"

    click_on "Delete Shelter"
    expect(current_path).to eq('/shelters')
    expect(page).to_not have_content(shelter1.name)
    expect(page).to have_content(shelter2.name)
  end

  it 'should not be able to be deleted if any of its pets are pending' do
    shelter = create(:shelter, name: "Delete Shelter Test")
    pet = create(:pet, adoptable: "Pending", shelter: shelter)
    adopt_form = create(:adopt_form)

    visit "/shelters/#{shelter.id}"

    click_on "Delete Shelter"
    expect(current_path).to eq("/shelters/#{shelter.id}")
    expect(page).to have_content("Can't Delete Shelter with Pending Pet Applications")
  end

  it 'should be delete with all its pets if no pets are pending' do
    shelter = create(:shelter)
    pet = create(:pet, shelter: shelter)

    visit "/shelters/#{shelter.id}"

    click_on "Delete Shelter"

    expect(current_path).to eq("/shelters")
    expect(page).to have_content("Shelter Deleted")
  end

  it 'should be delete with all its reviews' do
    shelter = create(:shelter)
    review = create(:review, shelter: shelter)

    visit "/shelters/#{shelter.id}"

    click_on "Delete Shelter"

    expect(current_path).to eq("/shelters")
    expect(page).to have_content("Shelter Deleted")
  end
end
