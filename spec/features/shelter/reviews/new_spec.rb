require 'rails_helper'

RSpec.describe 'Shelter Review Functions', type: :feature do
  context 'as a user' do
    before :each do
      @shelter1 = create(:shelter)
      @shelter2 = create(:shelter, name: "Jane's Shelter", address: "321 2nd St.", city: "Denver", state: "CO", zip: "80020")
      @review1 = create(:review, shelter: @shelter1)
      @review2 = create(:review, title: "Shelter 2 Review", shelter: @shelter2)
    end

  it 'should show a link to create a review for the shelter' do
      visit "shelters/#{@shelter1.id}"

      click_on "Create Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")

      fill_in "title", with: "New Review 1"
      fill_in "rating", with: "5"
      fill_in "content", with: "Lovely Pet Shelter"

      expect(page).to have_field("image")

      click_on "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")
      
      # Test original review still there
      expect(page).to have_content(@review1.title)
      expect(page).to have_content(@review1.rating)
      expect(page).to have_content(@review1.content)
      expect(page).to have_css("img[src*='#{@review1.image}']")

      expect(page).to have_content("New Review 1")
      expect(page).to have_content("5")
      expect(page).to have_content("Lovely Pet Shelter")
    end

    it 'should be able to delete specific reviews' do
      visit "shelters/#{@shelter1.id}"

      within ".review-#{@review1.id}" do
        click_on "Delete Review"
      end

      expect(current_path).to eq("/shelters/#{@shelter1.id}")
      
      expect(page).to_not have_css(".review-#{@review1.id}")
    end

    it 'should so a flash message if not all information is inputted' do
      visit "/shelters/#{@shelter1.id}/reviews/new"

      click_on "Submit Review"
      
      expect(page).to have_content("Please fill in Title, Rating, and Content first!")
      expect(page).to have_button("Submit Review")
    end

    it 'should display default image if image field wont return image' do
      visit "shelters/#{@shelter1.id}"

      click_on "Create Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")

      fill_in "title", with: "New Review 1"
      fill_in "rating", with: "5"
      fill_in "content", with: "Lovely Pet Shelter"
      fill_in "image", with: "test"

      click_on "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")
      
      # Test original review still there
      within ".review-#{@shelter1.reviews.last.id}" do
        expect(page).to have_content("New Review 1")
        expect(page).to have_content("5")
        expect(page).to have_content("Lovely Pet Shelter")
        expect(page).to have_css("img[src*='https://sagemailer.com/blog/content/images/2019/12/Amazon-review-request-button.jpg']")
      end
    end
  end
end