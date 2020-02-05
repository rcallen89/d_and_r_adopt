require 'rails_helper'

RSpec.describe 'As a visitor of a shelter show page' do
  before(:each) do
    @shelter1 = create(:shelter)
    @shelter2 = create(:shelter, name: "Jane's Shelter", address: "321 2nd St.", city: "Denver", state: "CO", zip: "80020")
    @review1 = create(:review, shelter: @shelter1)
    @review2 = create(:review, title: "Shelter 2 Review", shelter: @shelter2)
  end

  it 'should show the individual shelter show page' do
    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content("Address: #{@shelter1.address} #{@shelter1.city}, #{@shelter1.state} #{@shelter1.zip}")
    expect(page).to have_link("Update Shelter")
    expect(page).to have_link("Delete Shelter")

    expect(page).to_not have_content(@shelter2.name)
    expect(page).to_not have_content("Address: #{@shelter2.address} #{@shelter2.city}, #{@shelter2.state} #{@shelter2.zip}")
  end

  it 'should take me to the shelters pets index page' do
    visit "/shelters/#{@shelter2.id}"
    click_on "Shelter's Pets"

    expect(current_path).to eq("/shelters/#{@shelter2.id}/pets")
  end

  it 'should show that shelters reviews' do
    visit "shelters/#{@shelter1.id}"
    
    expect(page).to have_content(@review1.title)
    expect(page).to have_content(@review1.rating)
    expect(page).to have_content(@review1.content)
    expect(page).to have_css("img[src*='#{@review1.image}']")

    expect(page).to_not have_content(@review2.title)
  end

  it 'should show a delete button for each review' do
    visit "shelters/#{@shelter1.id}"

    expect(page).to have_link("Delete Review", count: @shelter1.reviews.count)
  end

  it 'should show an edit button for each review' do
    visit "shelters/#{@shelter1.id}"
    
    expect(page).to have_link("Edit Review", count: @shelter1.reviews.count)
  end
end
