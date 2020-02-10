class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :image, default: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13002248/GettyImages-187066830.jpg"
      t.integer :approximate_age
      t.string :sex
      t.bigint :pending_app
      t.references :shelter, foreign_key: true

      t.timestamps
    end
  end
end
