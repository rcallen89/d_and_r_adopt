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
end
