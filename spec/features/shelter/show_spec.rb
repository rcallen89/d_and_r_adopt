require 'rails_helper'

RSpec.describe 'As a visitor of a shelter show page' do
  before(:each) do
    @shelter1 = Shelter.create!(name: "Joe's Shelter", address: "123 Main St.", city: "Dallas", state: "TX", zip: "75341")
    @shelter2 = Shelter.create!(name: "Jane's Shelter", address: "321 2nd St.", city: "Denver", state: "CO", zip: "80020")
  end

  it 'should show the individual shelter show page' do
    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content("Address: #{@shelter1.address} #{@shelter1.city}, #{@shelter1.state} #{@shelter1.zip}")
    expect(page).to have_link("Update Shelter")
    expect(page).to have_link("Delete Shelter")

    expect(page).to_not have_content(@shelter2.name)
    expect(page).to_not have_content("Address: #{@shelter2.address} #{@shelter2.city}, #{@shelter2.state} #{@shelter2.zip}")
  end

  it 'should take me to the shelters pets index page' do
    visit "/shelters/#{@shelter2.id}"
    click_on "Shelter's Pets"

    expect(current_path).to eq("/shelters/#{@shelter2.id}/pets")
  end
end
