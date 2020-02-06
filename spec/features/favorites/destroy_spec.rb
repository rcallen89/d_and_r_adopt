require 'rails_helper'

RSpec.describe 'As a user', method: :feature do
  before(:each) do
    @shelter1 = create(:shelter)

    @pet1 = create(:pet, shelter: @shelter1)
    @pet2 = create(:pet, 
                    name: "Kat",
                    approximate_age: 2,
                    sex: "Female",
                    description: 'Too Cool for School',
                    shelter: @shelter1)
    visit "/pets/#{@pet1.id}"
    click_on "Favorite Pet"
    visit "/pets/#{@pet2.id}"
    click_on "Favorite Pet"
  end

  it 'should remove pet from favorites' do
    within "nav" do
      expect(page).to have_button("Favorites: 2")
    end

    visit "/pets/#{@pet1.id}"
    click_on "Unfavorite Pet"

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Pet Removed from Favorites")

    within "nav" do
      expect(page).to have_button("Favorites: 1")
      click_on "Favorites: 1"
    end
    expect(page).to_not have_content(@pet1.name)
    expect(page).to have_content(@pet2.name)
  end

  it 'should remove pet from favorite index page' do
    visit '/favorites'
    
    within "#fav-#{@pet1.id}" do
      click_on "Unfavorite Pet"
    end
  
    expect(page).to have_content("Pet Removed from Favorites")
    expect(current_path).to eq("/favorites")
    expect(page).to_not have_content(@pet1.name)
    expect(page).to have_content(@pet2.name)

    within "nav" do
      expect(page).to have_button("Favorites: 1")
    end
  end

  it 'should remove all pets from favorite index page' do
    visit '/favorites'
    expect(page).to have_link("Remove All Favorited Pets")

    click_on "Remove All Favorited Pets"
    
    expect(current_path).to eq("/favorites")
    expect(page).to have_content('You currently do not have any favorites')

    within "nav" do
      expect(page).to have_button("Favorites: 0")
    end
  end
end