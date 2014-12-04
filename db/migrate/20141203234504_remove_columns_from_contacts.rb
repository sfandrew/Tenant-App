class RemoveColumnsFromContacts < ActiveRecord::Migration
  def change
  	remove_column :contacts, :contactable_id
  	remove_column :contacts, :contactable_type
  end
end
