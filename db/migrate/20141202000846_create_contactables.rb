class CreateContactables < ActiveRecord::Migration
  def change
    create_table :contactables do |t|
      t.integer :contact_id
      t.string :contactable_type
      t.integer :contactable_id

      t.timestamps
    end
  end
end
