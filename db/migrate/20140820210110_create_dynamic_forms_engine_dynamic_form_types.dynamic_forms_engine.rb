# This migration comes from dynamic_forms_engine (originally 20140718180134)
class CreateDynamicFormsEngineDynamicFormTypes < ActiveRecord::Migration
  def change
    create_table :dynamic_forms_engine_dynamic_form_types do |t|
      t.string :name
      t.text :description
      t.string :uuid

      t.timestamps
    end
  end
end
