# This migration comes from dynamic_forms_engine (originally 20140814005126)
class AddFormTypeToDynamicFormsEngineDynamicFormType < ActiveRecord::Migration
  def change
    add_column :dynamic_forms_engine_dynamic_form_types, :form_type, :string unless column_exists? :dynamic_forms_engine_dynamic_form_types, :form_type
  end
end
