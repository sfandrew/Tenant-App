class AddAppFeeToDynamicFormEntries < ActiveRecord::Migration
  def change
  	add_column :dynamic_forms_engine_dynamic_form_entries, :app_fee_paid, :boolean
  end
end
