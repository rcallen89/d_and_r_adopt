require 'rails_helper'

RSpec.describe 'Adopt Form Index Page', type: :feature do
  context 'as a user' do
    before :each do
      @pet1 = create(:pet)
      @adopt_form1 = create(:adopt_form)
    end

    it 'shows a list of all current applications' do
      create(:pet_adopt_form, adopt_form: @adopt_form1, pet: @pet1)

      visit "pets/#{@pet1.id}/adopt_forms"

      expect(page).to have_link("#{@adopt_form1.name}'s Application")
    end

    it 'shows no applications if there are no applications' do
      visit "pets/#{@pet1.id}/adopt_forms"

      expect(page).not_to have_link("#{@adopt_form1.name}'s Application")
      expect(page).to have_content("There are no applications for #{@pet1.name} at this time.")
    end
  end
end