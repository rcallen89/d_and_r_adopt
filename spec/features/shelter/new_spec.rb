require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  it 'should create a new shelter' do
    visit '/shelters'
    expect(page).to_not have_content("Marc's Shelter")

    click_on "New Shelter"
    expect(current_path).to eq("/shelters/new")

    fill_in :name, with: "Marc's Shelter"
    fill_in :address, with: "222 Victory Rd."
    fill_in :city, with: "Okinawa"
    fill_in :state, with: "TX"
    fill_in :zip, with: "75231"

    click_on "Create Shelter"

    expect(current_path).to eq('/shelters')
    expect(page).to have_content("Marc's Shelter")
    expect(page).to have_content("Shelter Created")
  end

  it 'should display a message if not all information is filled out' do
    visit '/shelters'
    expect(page).to_not have_content("Marc's Shelter")

    click_on "New Shelter"
    expect(current_path).to eq("/shelters/new")

    fill_in :name, with: "Marc's Shelter"
    fill_in :state, with: "TX"
    fill_in :zip, with: "75231"

    click_on "Create Shelter"
    
    expect(page).to have_content("Address can't be blank and City can't be blank")
  end
end
