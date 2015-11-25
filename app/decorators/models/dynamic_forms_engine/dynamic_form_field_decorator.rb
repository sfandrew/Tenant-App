DynamicFormsEngine::DynamicFormField.class_eval  do

	# returns all fields that are mapped into taz
	def self.all_fields_with_values
		sorted_tenant_fields = where(:dynamic_form_type => Rails.application.config.tenant_app_id).sort_by { |field| field.field_order}
		sorted_guarantor_fields = where(:dynamic_form_type => Rails.application.config.guarantor_app_id).sort_by { |field| field.field_order}

		non_value_fields = DynamicFormsEngine::DynamicFormField.class_variable_get(:@@field_with_null_value)
		non_value_fields.delete("field_group")

		tenant_fields_with_values = sorted_tenant_fields.delete_if { |field| non_value_fields.include?(field.field_type) }
		guarantor_fields_with_values = sorted_guarantor_fields.delete_if { |field| non_value_fields.include?(field.field_type) }

		tenant_fields_with_field_group = {:Tenant => {} }
		guarantor_fields_with_field_group = {:Guarantor => {}}

		current_field_group = ""

		tenant_fields_with_values.each do |field|

			if field.field_type == 'field_group'
				current_field_group = field.name
				tenant_fields_with_field_group[current_field_group] = Array.new
			end

			tenant_fields_with_field_group[current_field_group] << field.name
		end

		guarantor_fields_with_values.each do |field|

			if field.field_type == 'field_group'
				current_field_group = field.name
				guarantor_fields_with_field_group[current_field_group] = Array.new
			end

			guarantor_fields_with_field_group[current_field_group] << field.name
		end

		return tenant_fields_with_field_group, guarantor_fields_with_field_group

	end
end