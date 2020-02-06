require 'rails_helper'

RSpec.describe "A new form for adoption" do
  before :each do
    @shelter1 = create(:shelter)
    @shelter2 = create(:shelter, name: "Jane's Shelter", address: "321 2nd St.", city: "Denver", state: "CO", zip: "80020")
    @pet1 = create(:pet, shelter: @shelter1)
    @pet2 = create(:pet, 
                    name: "Kat",
                    approximate_age: 2,
                    sex: "Female",
                    description: 'Too Hot for School',
                    shelter: @shelter2)

    visit "/pets/#{@pet1.id}"
    click_on 'Favorite Pet'
    visit "/pets/#{@pet2.id}"
    click_on 'Favorite Pet'
  end

  it 'can see checkboxes for favorite pets' do
    visit '/adopt_forms/new'
    
    expect(page).to have_unchecked_field(@pet1.name)
    expect(page).to have_unchecked_field(@pet2.name)
  end

  it 'can submit form for adopter information' do
    visit '/adopt_forms/new'

    check "#{@pet1.name}"

    fill_in "name", with: "Sally"
    fill_in "address", with: "1234 Main St."
    fill_in "city", with: "Denver"
    fill_in "state", with: "CO"
    fill_in "zip", with: "80222"
    fill_in "phone_number", with: "303-111-1234"
    fill_in "description", with: "I would be a great pet parent"

    click_on "Submit Application"

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Application Submitted")
    
    expect(page).not_to have_css("#fav-#{@pet1.id}")

    expect(page).to have_css("#fav-#{@pet2.id}")
  end
end