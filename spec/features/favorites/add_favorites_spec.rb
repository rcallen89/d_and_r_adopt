require 'rails_helper'

RSpec.describe 'As a visitor to the favorites page', method: :feature do
  before(:each) do
    @shelter1 = create(:shelter)

    @pet1 = create(:pet, shelter: @shelter1)
    @pet2 = create(:pet, shelter: @shelter1)
  end

  it 'should be able to add a pet to favorites' do
    visit "/pets/#{@pet1.id}"
    click_on "Favorite Pet"

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Pet added to Favorites")
    within "nav" do
      expect(page).to have_button("Favorites: 1")
    end

    visit "/pets/#{@pet2.id}"

    within "nav" do
      expect(page).to have_button("Favorites: 1")
    end

    click_on "Favorite Pet"

    expect(current_path).to eq("/pets/#{@pet2.id}")
    within "nav" do
      expect(page).to have_button("Favorites: 2")
    end
  end

  it 'should not be able to add a pet to favorites again' do
    visit "/pets/#{@pet1.id}"
    click_on "Favorite Pet"
    within "nav" do
      expect(page).to have_button("Favorites: 1")
    end
    expect(current_path).to eq("/pets/#{@pet1.id}")

    expect(page).to have_link("Unfavorite Pet")
    expect(page).to_not have_link("Favorite Pet")
  end

end