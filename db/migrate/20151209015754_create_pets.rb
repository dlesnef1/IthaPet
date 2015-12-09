class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.string :image
      t.text :biography
      t.integer :hungriness
      t.integer :happiness
      t.integer :cleanliness
      t.integer :loyalty
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false

    end
    add_index :pets, [:user_id, :created_at]
  end
end
