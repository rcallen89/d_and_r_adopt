require 'rails_helper'

RSpec.describe 'Adopt Form Show Page', type: :feature do
  context 'as a user' do
    before :each do
      @pet1 = create(:pet)
      @adopt_form1 = create(:adopt_form)
      create(:pet_adopt_form, adopt_form: @adopt_form1, pet: @pet1)
    end

    it 'can view the adopt form info with links to pets in it' do
      visit "/adopt_forms/#{@adopt_form1.id}"

      expect(page).to have_content("Sally")
      expect(page).to have_content("1234 Main St.")
      expect(page).to have_content("Denver")
      expect(page).to have_content("CO")
      expect(page).to have_content("80123")
      expect(page).to have_content("303-111-1234")
      expect(page).to have_content("I would be a great pet parent")

      expect(page).to have_link("#{@pet1.name}")
    end
  end
end