class DynamicFormsEngine::DynamicFormEntrySerializer < ActiveModel::Serializer
 
	def attributes
	  	entry = {}
	  	entry.merge!(application_name: object.dynamic_form_type.name, id: object.id, in_progress: object.in_progress, created: object.created_at, updated: object.updated_at, 
	  				uuid: object.uuid, app_fee_paid: object.app_fee_paid, user_email: object.user.email, ss: object.decrypt_ss)

	  	field_group_name = ''
	  	object.properties.each_value do |value|

	  		if value[:type] == "field_group"
	  			field_group_name = value[:name]
	  			entry[field_group_name] = {}
	  		elsif DynamicFormsEngine::DynamicFormField.field_with_null_value.include?(value[:type])
	  			next
	  		elsif value[:type] == "file_upload"
	  			attachment = object.attachments.find { |file_upload| file_upload.content_meta == value[:id] }
	  			entry[field_group_name][value[:name]] = attachment.filename.url unless attachment.nil?
	  		else 
	  			entry[field_group_name][value[:name]] = value[:value]
	  		end

	  	end
	  	entry
	  	
	end


end
