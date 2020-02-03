require 'rails_helper'

RSpec.describe 'As a visitor to a shelters pets index page', type: :feature do
  before(:each) do
    @shelter1 = create(:shelter)
    @shelter2 = create(:shelter, name: "Jane's Shelter", address: "321 2nd St.", city: "Denver", state: "CO", zip: "80020")

    @pet1 = create(:pet, shelter: @shelter1)
    @pet2 = create(:pet,
                  name: "Kat",
                  image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002248/GettyImages-187066830.jpg",
                  approximate_age: 2,
                  sex: "Female",
                  description: 'Too Cool for School',
                  shelter: @shelter1)
    @pet3 = create(:pet,
                  name: "Peppo",
                  image: "https://adopt-dont-shop.s3-us-west-1.amazonaws.com/images/mexican_hairless_105.jpg",
                  approximate_age: 5,
                  sex: "Male",
                  description: 'Too Cool for School',
                  shelter: @shelter2)
    
    visit "/shelters/#{@shelter1.id}/pets"
  end

  it 'should only show pets from that shelter' do

    expect(page).to have_content(@pet1.name)
    expect(page).to have_css("img[src*='#{@pet1.image}']")
    expect(page).to have_content(@pet1.approximate_age)
    expect(page).to have_content(@pet1.sex)

    expect(page).to have_content(@pet2.name)
    expect(page).to have_css("img[src*='#{@pet2.image}']")
    expect(page).to have_content(@pet2.approximate_age)
    expect(page).to have_content(@pet2.sex)

    expect(page).to_not have_content(@pet3.name)
    expect(page).to_not have_css("img[src*='#{@pet3.image}']")
    expect(page).to_not have_content(@pet3.approximate_age)
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
    expect(page).to have_content("Peppo")
    expect(page).to_not have_content("Kat")
  end

  it 'should take me to the shelters show page from the name' do
    click_on @shelter1.name

    expect(current_path).to eq("/shelters/#{@shelter1.id}")
  end

  it 'should take me to the pets show page from the name' do
    click_on @pet2.name

    expect(current_path).to eq("/pets/#{@pet2.id}")
  end
end
