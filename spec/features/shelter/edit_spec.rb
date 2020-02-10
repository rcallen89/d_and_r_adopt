require 'rails_helper'

RSpec.describe 'As a visitor of a shelter show page' do
  before(:each) do
    @shelter1 = create(:shelter)
  end

  it 'should update individual shelter information' do
    visit "/shelters/#{@shelter1.id}"

    expect(page).to_not have_content("Address: 321 2nd St. Denver, CO, 80020")

    click_on "Update Shelter"
    expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")

    fill_in :address, with: "321 2nd St."
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip, with: "80020"

    click_on "Update"

    expect(current_path).to eq("/shelters/#{@shelter1.id}")
    expect(page).to have_content("Address: 321 2nd St. Denver, CO 80020")
    expect(page).to_not have_content("Address: 123 Main St. Dallas, TX 75341")
  end

  it 'should show error message on incomplete form' do
    visit "/shelters/#{@shelter1.id}"

    expect(page).to_not have_content("Address: 321 2nd St. Denver, CO, 80020")

    click_on "Update Shelter"
    expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")

    fill_in :address, with: "321 2nd St."
    fill_in :city, with: ""
    fill_in :state, with: "CO"
    fill_in :zip, with: "80020"

    click_on "Update"


    expect(page).to have_content("City can't be blank")
  end
end
