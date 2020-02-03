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
end