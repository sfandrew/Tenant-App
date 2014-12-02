class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :contact_type
      t.integer :contactable_id
      t.string :contactable_type
      t.string :name
      t.string :company
      t.string :email
      t.string :phone
      t.integer :uuid

      t.timestamps
    end
  end
end
