class AddNewFieldsToContacts < ActiveRecord::Migration
  def change
  	rename_column :contacts, :name, :first_name
    add_column :contacts, :address1, :string
    add_column :contacts, :address2, :string
    add_column :contacts, :city, :string
    add_column :contacts, :state, :string
    add_column :contacts, :zip, :string
  end
end
