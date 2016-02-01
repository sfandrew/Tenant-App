class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :dynamic_form_entry_id
      t.string :braintree_id
      t.string :payment_type
      t.decimal :amount

      t.timestamps
    end
  end
end
