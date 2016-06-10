DynamicFormsEngine::DynamicFormField.class_eval  do

	# returns all fields that are mapped into taz
	def self.all_fields_with_values
		sorted_tenant_fields = where(:dynamic_form_type => Rails.application.config.tenant_app_id).sort_by { |field| field.field_order}
		sorted_guarantor_fields = where(:dynamic_form_type => Rails.application.config.guarantor_app_id).sort_by { |field| field.field_order}
		sorted_cla_fields = where(:dynamic_form_type => Rails.application.config.cla_app_id).sort_by { |field| field.field_order}

		non_value_fields = DynamicFormsEngine::DynamicFormField.class_variable_get(:@@field_with_null_value)
		non_value_fields.delete("field_group")

		tenant_fields_with_values = sorted_tenant_fields.delete_if { |field| non_value_fields.include?(field.field_type) }
		guarantor_fields_with_values = sorted_guarantor_fields.delete_if { |field| non_value_fields.include?(field.field_type) }
		cla_fields_with_values = sorted_cla_fields.delete_if { |field| non_value_fields.include?(field.field_type) }

		tenant_fields_with_field_group = {:Tenant => {} }
		guarantor_fields_with_field_group = {:Guarantor => {}}
		cla_fields_with_field_group = {:Claridge => {}}

		DynamicFormsEngine::DynamicFormField.field_group_fields(tenant_fields_with_values,tenant_fields_with_field_group)
		DynamicFormsEngine::DynamicFormField.field_group_fields(guarantor_fields_with_values,guarantor_fields_with_field_group)
		DynamicFormsEngine::DynamicFormField.field_group_fields(cla_fields_with_values,cla_fields_with_field_group)

		return tenant_fields_with_field_group, guarantor_fields_with_field_group, cla_fields_with_field_group

	end

	def self.field_group_fields(form_type_fields, form_type_field_group)
		current_field_group = ""
		form_type_fields.each do |field|

			if field.type_field_group?
				current_field_group = field.name
				form_type_field_group[current_field_group] = Array.new
			end

			form_type_field_group[current_field_group] << field.name

		end
	end

end