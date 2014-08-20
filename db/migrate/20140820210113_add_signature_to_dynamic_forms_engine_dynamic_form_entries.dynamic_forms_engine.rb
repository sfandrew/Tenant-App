# This migration comes from dynamic_forms_engine (originally 20140725192514)
class AddSignatureToDynamicFormsEngineDynamicFormEntries < ActiveRecord::Migration
  def change
    add_column :dynamic_forms_engine_dynamic_form_entries, :signature, :text
  end
end
