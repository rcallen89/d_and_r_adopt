class CreatePetAdoptForms < ActiveRecord::Migration[5.1]
  def change
    create_table :pet_adopt_forms do |t|
      t.references :pet
      t.references :adopt_form
    end
  end
end
