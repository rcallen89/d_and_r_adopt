require 'rails_helper'

RSpec.describe 'As a visitor of the Shelter index page' do
  before(:each) do
    @shelter1 = Shelter.create!(name: "Joe's Shelter", address: "123 Main St.", city: "Dallas", state: "TX", zip: "75341")
    @shelter2 = Shelter.create!(name: "Jane's Shelter", address: "321 2nd St.", city: "Denver", state: "CO", zip: "80020")
    visit '/shelters'
  end

  it 'should show all the shelters on the index page' do
    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content(@shelter2.name)
    expect(page).to have_link("New Shelter")
  end

  it 'should update a shelter' do
    within ".shelter-#{@shelter2.id}" do
      click_on "Update Shelter"
    end

    expect(current_path).to eq("/shelters/#{@shelter2.id}/edit")

    fill_in :name, with: "Tron's Shelter"
    fill_in :city, with: "Arlington"
    click_on "Update"

    expect(current_path).to eq("/shelters/#{@shelter2.id}")

    expect(page).to have_content("Tron's Shelter")
    expect(page).to have_content("Arlington")

    expect(page).to_not have_content("Jane's Shelter")
    expect(page).to_not have_content("Denver")
  end

  it 'should delete a shelter' do
    within ".shelter-#{@shelter2.id}" do
      click_on "Delete Shelter"
    end

    expect(current_path).to eq("/shelters")
    expect(page).to have_content("Joe's Shelter")
    expect(page).to_not have_content("Jane's Shelter")
  end

  it 'should take me to the shelters show page from the name' do
    click_on @shelter2.name

    expect(current_path).to eq("/shelters/#{@shelter2.id}")
  end
end
