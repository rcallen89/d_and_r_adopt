require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  it 'should take me to the shelters page from the nav' do
    visit '/pets'
    click_on "Shelters"

    expect(current_path).to eq("/shelters")
  end

  it 'should take me to the pets index page from the nav' do
    visit '/shelters'
    click_on "Pets"

    expect(current_path).to eq("/pets")
  end

  it 'should show amount of favorites as 0 when there are no favorites' do
    visit '/shelters'
    within "nav" do
      expect(page).to have_button("Favorites: 0")
    end
    visit '/pets'
    within "nav" do
      expect(page).to have_button("Favorites: 0")
    end
  end
end