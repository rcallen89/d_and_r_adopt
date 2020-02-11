require 'rails_helper'

RSpec.describe 'Adopt Form Show Page', type: :feature do
  context 'as a user' do
    before :each do
      @pet1 = create(:pet)
      @pet2 = create(:pet)
      @adopt_form1 = create(:adopt_form)
      @adopt_form2 = create(:adopt_form, name: "Becky")
      create(:pet_adopt_form, adopt_form: @adopt_form1, pet: @pet1)
      create(:pet_adopt_form, adopt_form: @adopt_form2, pet: @pet1)
      create(:pet_adopt_form, adopt_form: @adopt_form2, pet: @pet2)
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

    it 'pet as a link to approve the app for and takes to pet page with pending status' do
      visit "/adopt_forms/#{@adopt_form1.id}"

      expect(page).to have_content("Sally")
      expect(page).to have_content("1234 Main St.")
      expect(page).to have_content("Denver")
      expect(page).to have_content("CO")
      expect(page).to have_content("80123")
      expect(page).to have_content("303-111-1234")
      expect(page).to have_content("I would be a great pet parent")

      within "#pet-#{@pet1.id}" do
        click_on "Approve Application for #{@pet1.name}"
      end

      expect(current_path).to eq("/pets/#{@pet1.id}")

      expect(page).to have_content("Status: Pending")
      expect(page).to have_content("On hold for #{@adopt_form1.name}")
    end

    it 'each pet in the app has an approval link' do
      visit "/adopt_forms/#{@adopt_form2.id}"

      expect(page).to have_content("Becky")
      expect(page).to have_content("1234 Main St.")
      expect(page).to have_content("Denver")
      expect(page).to have_content("CO")
      expect(page).to have_content("80123")
      expect(page).to have_content("303-111-1234")
      expect(page).to have_content("I would be a great pet parent")

      within "#pet-#{@pet1.id}" do
        expect(page).to have_content("Approve Application for #{@pet1.name}")
      end

      within "#pet-#{@pet2.id}" do
        expect(page).to have_content("Approve Application for #{@pet2.name}")
      end
    end

    it 'a pet cant be approved in two different applications' do
      visit "/adopt_forms/#{@adopt_form1.id}"

      expect(page).to have_content("Sally")

      within "#pet-#{@pet1.id}" do
        click_on "Approve Application for #{@pet1.name}"
      end

      visit "/adopt_forms/#{@adopt_form2.id}"

      within "#pet-#{@pet1.id}" do
        expect(page).not_to have_content("Approve Application for #{@pet1.name}")
        expect(page).to have_content("#{@pet1.name} already pending.")

      end

      within "#pet-#{@pet2.id}" do
        expect(page).to have_content("Approve Application for #{@pet2.name}")
      end
    end

    it 'pet adoption can be revoked, status returns to pending' do
      visit "/adopt_forms/#{@adopt_form1.id}"

      expect(page).to have_content("Sally")
      expect(page).to have_content("1234 Main St.")
      expect(page).to have_content("Denver")
      expect(page).to have_content("CO")
      expect(page).to have_content("80123")
      expect(page).to have_content("303-111-1234")
      expect(page).to have_content("I would be a great pet parent")

      within "#pet-#{@pet1.id}" do
        click_on "Approve Application for #{@pet1.name}"
      end

      expect(current_path).to eq("/pets/#{@pet1.id}")

      expect(page).to have_content("Status: Pending")
      expect(page).to have_content("On hold for #{@adopt_form1.name}")

      visit "/adopt_forms/#{@adopt_form1.id}"

      within "#pet-#{@pet1.id}" do
        click_on "Revoke Application for #{@pet1.name}"
      end

      expect(current_path).to eq("/adopt_forms/#{@adopt_form1.id}")

      within "#pet-#{@pet1.id}" do
        expect(page).to have_content("Approve Application for #{@pet1.name}")
      end

      visit "/pets/#{@pet1.id}"

      expect(page).to have_content("Status: Available")
      expect(page).not_to have_content("On hold for")
    end
  end
end