require 'rails_helper'

RSpec.describe 'Shelter Review Edit Functions', type: :feature do
  context 'as a user' do

    before :each do
      @shelter1 = create(:shelter)
      @review1 = create(:review, shelter: @shelter1)
    end

    it 'should show a link to edit a review for the shelter' do
      visit "shelters/#{@shelter1.id}"

      within ".review-#{@review1.id}" do
        click_on "Edit Review"
      end

      expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/#{@review1.id}/edit")

      expect(page).to have_field('title', with: "#{@review1.title}")
      expect(page).to have_field('rating', with: "#{@review1.rating}")
        expect(page).to have_field('content', with: "#{@review1.content}")

      fill_in "title", with: "Edits"
      fill_in "rating", with: "1"
      fill_in "content", with: "Bad Shelter"

      expect(page).to have_field("image")

      click_on "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")
        
        # Test original review not there
      within ".review-#{@review1.id}" do
        expect(page).to_not have_content("Joe's Shelter Review")
        expect(page).to_not have_content("4")
        expect(page).to_not have_content("This was a great shelter to work with.")

        expect(page).to have_content("Edits")
        expect(page).to have_content("1")
        expect(page).to have_content("Bad Shelter")
      end
    end

    it 'should show flash messages if missing information in edit' do
      visit "/shelters/#{@shelter1.id}/reviews/#{@review1.id}/edit"

      fill_in "title", with: ""

      click_on "Submit Review"
      
      expect(page).to have_content("Please fill in Title, Rating, and Content first!")
      expect(page).to have_button("Submit Review")
    end
  end
end
