class AddAdoptableToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :adoptable, :integer, default: 0
  end
end
