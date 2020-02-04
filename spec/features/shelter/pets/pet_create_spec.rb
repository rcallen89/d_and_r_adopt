require 'rails_helper'

RSpec.describe 'As a visitor to a shelters pets index page', type: :feature do
  before(:each) do
    @shelter1 = create(:shelter)
  end

  it 'should let me create new pet' do
    visit "/shelters/#{@shelter1.id}/pets"
    expect(page).to_not have_content("Tron")

    click_on "Create Pet"
    expect(current_path).to eq("/shelters/#{@shelter1.id}/pets/new")

    fill_in :name, with: "Tron"
    fill_in :approximate_age, with: 2
    fill_in :sex, with: "Male"
    fill_in :description, with: "Too Cool for School"

    click_on "Create Pet"

    expect(current_path).to eq("/shelters/#{@shelter1.id}/pets")
    
    expect(page).to have_content("Tron")
    expect(page).to have_content(2)
    expect(page).to have_content("Male")
  end
end