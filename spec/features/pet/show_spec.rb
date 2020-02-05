require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  before :each do
    @shelter1 = create(:shelter)

    @pet1 = create(:pet, shelter: @shelter1)

    @pet2 = create(:pet, 
                    name: "Kat",
                    approximate_age: 2,
                    sex: "Female",
                    description: 'Too Hot for School',
                    shelter: @shelter1)
  end
  it 'should show an individual pets show page' do

    visit "/pets/#{@pet1.id}"

    expect(page).to have_content(@pet1.name)
    expect(page).to have_css("img[src*='#{@pet1.image}']")
    expect(page).to have_content(@pet1.approximate_age)
    expect(page).to have_content(@pet1.sex)
    expect(page).to have_content(@pet1.description)
    expect(page).to have_content(@pet1.adoptable)
    expect(page).to have_link("Update Pet")
    expect(page).to have_link("Delete Pet")
    expect(page).to have_link("Favorite Pet")

    expect(page).to_not have_content(@pet2.name)
    expect(page).to_not have_content(@pet2.approximate_age)
    expect(page).to_not have_content(@pet2.sex)
    expect(page).to_not have_content(@pet2.description)
  end

  it 'should take me to the pets show page from the name' do

    visit "/pets/#{@pet1.id}"
    click_on @pet1.name

    expect(current_path).to eq("/pets/#{@pet1.id}")
  end
end