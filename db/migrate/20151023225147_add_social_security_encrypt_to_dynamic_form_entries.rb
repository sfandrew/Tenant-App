class AddSocialSecurityEncryptToDynamicFormEntries < ActiveRecord::Migration
  def change
  	add_column :dynamic_forms_engine_dynamic_form_entries, :social_security, :binary
  	add_column :dynamic_forms_engine_dynamic_form_entries, :social_security_key, :binary
  	add_column :dynamic_forms_engine_dynamic_form_entries, :social_security_iv, :binary
  end
end
