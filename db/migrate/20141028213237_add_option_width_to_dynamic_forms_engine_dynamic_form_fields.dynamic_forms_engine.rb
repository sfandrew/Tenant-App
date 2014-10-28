# This migration comes from dynamic_forms_engine (originally 20141008220450)
class AddOptionWidthToDynamicFormsEngineDynamicFormFields < ActiveRecord::Migration
  def change
    add_column :dynamic_forms_engine_dynamic_form_fields, :field_width, :string
  end
end
