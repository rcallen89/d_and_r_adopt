require 'rails_helper'

RSpec.describe 'As a visitor' do

  before(:each) do
    @shelter1 = Shelter.create!(name: "Joe's Shelter", address: "123 Main St.", city: "Dallas", state: "TX", zip: "75341")
    @pet1 = @shelter1.pets.create!(name: "Tron",
    approximate_age: 3,
    sex: "Male",
    description: 'Too Cool for School')
    @pet2 = @shelter1.pets.create!(name: "Kat",
    approximate_age: 2,
    sex: "Female",
    description: 'Too Cool for School')
    
    visit '/pets'
  end
  
  it 'should show a list of all the pets' do
    within ".pets-#{@pet1.id}" do
      expect(page).to have_content(@pet1.name)
      expect(page).to have_css("img[src*='#{@pet1.image}']")
      expect(page).to have_content(@pet1.approximate_age)
      expect(page).to have_content(@pet1.sex)
      expect(page).to have_content(@pet1.shelter.name)
    end

    within ".pets-#{@pet2.id}" do
      expect(page).to have_content(@pet2.name)
      expect(page).to have_css("img[src*='#{@pet2.image}']")
      expect(page).to have_content(@pet2.approximate_age)
      expect(page).to have_content(@pet2.sex)
      expect(page).to have_content(@pet2.shelter.name)
    end
  end

  it 'should update a pet' do
    within ".pets-#{@pet2.id}" do
      click_on "Update Pet"
    end

    expect(current_path).to eq("/pets/#{@pet2.id}/edit")

    fill_in :name, with: "Dougie"
    fill_in :approximate_age, with: 4
    click_on "Update Pet"

    expect(current_path).to eq("/pets/#{@pet2.id}")

    expect(page).to have_content("Dougie")
    expect(page).to have_content(4)

    expect(page).to_not have_content("Kat")
    expect(page).to_not have_content(2)
  end

  it 'should delete a pet' do
    within ".pets-#{@pet2.id}" do
      click_on "Delete Pet"
    end

    expect(current_path).to eq("/pets")
    expect(page).to have_content("Tron")
    expect(page).to_not have_content("Kat")
  end

  it 'should take me to the shelters show page from the name' do
    within ".pets-#{@pet2.id}" do
      click_on @shelter1.name
    end

    expect(current_path).to eq("/shelters/#{@shelter1.id}")
  end

  it 'should take me to the pets show page from the name' do
    click_on @pet2.name

    expect(current_path).to eq("/pets/#{@pet2.id}")
  end
end
