# This migration comes from dynamic_forms_engine (originally 20141006225835)
class AddIncludedInReportToDynamicFormsEngineDynamicFormEntries < ActiveRecord::Migration
  def change
    add_column :dynamic_forms_engine_dynamic_form_fields, :included_in_report, :boolean
  end
end
