require 'rails_helper'

RSpec.describe 'As a visitor to favorites index', method: :feature do
  before(:each) do
    @shelter1 = create(:shelter)

    @pet1 = create(:pet, shelter: @shelter1)
    @pet2 = create(:pet, 
                    name: "Kat",
                    approximate_age: 2,
                    sex: "Female",
                    description: 'Too Cool for School',
                    shelter: @shelter1)
  end

  it 'should take me to favorites index from indicator button' do
    visit '/shelters'

    click_on 'Favorites: 0'
    expect(current_path).to eq('/favorites')
    expect(page).to have_content('List of Your Favorited Pets')
  end

  it 'should show a message when there are no favorited pets' do
    visit '/favorites'
    expect(page).to have_content('You currently do not have any favorites')
  end


  it 'should show favorited pets' do
    visit "/pets/#{@pet1.id}"
    click_on "Favorite Pet"
    visit "/pets/#{@pet2.id}"
    click_on "Favorite Pet"

    click_on 'Favorites: 2'

    expect(current_path).to eq('/favorites')
    within "#fav-#{@pet1.id}" do
      expect(page).to have_link(@pet1.name)
      expect(page).to have_css("img[src*='#{@pet1.image}']")
      expect(page).to have_link("Unfavorite Pet")

      expect(page).to_not have_link(@pet2.name)
    end

    within "#fav-#{@pet2.id}" do
      expect(page).to have_link(@pet2.name)
      expect(page).to have_css("img[src*='#{@pet2.image}']")
      expect(page).to have_link("Unfavorite Pet")

      expect(page).to_not have_link(@pet1.name)
    end
  end

  it "if there are favorites there is an option to start a new app" do
    visit '/favorites'

    expect(page).not_to have_link("New Application")

    visit "/pets/#{@pet1.id}"

    click_on "Favorite Pet"

    visit '/favorites'
    
    expect(page).to have_link("New Application")
  end

  it 'shows a section of pets that apps out for them' do
    create(:pet_adopt_form, pet: @pet1)

    visit '/favorites'
    
    within "#pending-pets" do
      expect(page).to have_link("#{@pet1.name}")
    end

  end
end