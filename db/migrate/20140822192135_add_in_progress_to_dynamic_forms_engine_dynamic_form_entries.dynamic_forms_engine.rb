# This migration comes from dynamic_forms_engine (originally 20140819203317)
class AddInProgressToDynamicFormsEngineDynamicFormEntries < ActiveRecord::Migration
  def change
    add_column :dynamic_forms_engine_dynamic_form_entries, :in_progress, :boolean unless column_exists? :dynamic_forms_engine_dynamic_form_entries, :in_progress
  end
end
