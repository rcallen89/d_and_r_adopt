require 'rails_helper'

RSpec.describe 'As a visitor to a pets show page', type: :feature do
  before(:each) do
    @shelter1 = create(:shelter)

    @pet1 = create(:pet, shelter: @shelter1)
  end

  it 'should delete pet' do
    visit "/pets"

    expect(page).to have_content("Tron")

    visit "/pets/#{@pet1.id}"

    click_on "Delete Pet"

    expect(current_path).to eq("/pets")

    expect(page).to_not have_content("Tron")
  end

  it 'should not delete pet if it has a pending application' do
    visit "/pets/#{@pet1.id}"
    click_on "Favorite Pet"

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

    visit "/pets/#{@pet1.id}"

    click_on "Applications"
    click_on "Sally"
    click_on "Approve Application for #{@pet1.name}"

    visit "/pets/#{@pet1.id}"
    click_on "Delete Pet"
    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Cannot Delete a Pet with an Approved Application")
  end

  it 'should remove pet from favorites when deleted' do
    visit "/pets/#{@pet1.id}"
    click_on "Favorite Pet"

    within "nav" do
      expect(page).to have_button("Favorites: 1")
    end

    click_on "Delete Pet"

    within "nav" do
      expect(page).to have_button("Favorites: 0")
    end
  end
end