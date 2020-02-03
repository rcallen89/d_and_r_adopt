require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  it 'should show an individual pets show page' do
    shelter1 = Shelter.create!(name: "Joe's Shelter", address: "123 Main St.", city: "Dallas", state: "TX", zip: "75341")
    pet1 = shelter1.pets.create!(name: "Tron",
                       description: "Too Cool for School",
                       approximate_age: 3,
                       sex: "Male")
    pet2 = shelter1.pets.create!(name: "Kat",
                      description: "Too Hot for School",
                      approximate_age: 2,
                      sex: "Female")

    visit "/pets/#{pet1.id}"

    expect(page).to have_content(pet1.name)
    expect(page).to have_css("img[src*='#{pet1.image}']")
    expect(page).to have_content(pet1.approximate_age)
    expect(page).to have_content(pet1.sex)
    expect(page).to have_content(pet1.description)
    expect(page).to have_content(pet1.adoptable)
    expect(page).to have_link("Update Pet")
    expect(page).to have_link("Delete Pet")

    expect(page).to_not have_content(pet2.name)
    expect(page).to_not have_content(pet2.approximate_age)
    expect(page).to_not have_content(pet2.sex)
    expect(page).to_not have_content(pet2.description)
  end

  it 'should take me to the pets show page from the name' do
    shelter1 = Shelter.create!(name: "Joe's Shelter", address: "123 Main St.", city: "Dallas", state: "TX", zip: "75341")
    pet1 = shelter1.pets.create!(name: "Tron",
                       description: "Too Cool for School",
                       approximate_age: 3,
                       sex: "Male")

    visit "/pets/#{pet1.id}"
    click_on pet1.name

    expect(current_path).to eq("/pets/#{pet1.id}")
  end
end