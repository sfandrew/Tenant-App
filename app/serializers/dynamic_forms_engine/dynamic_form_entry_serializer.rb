class DynamicFormsEngine::DynamicFormEntrySerializer < ActiveModel::Serializer
  # attributes :id, :dynamic_form_type_id, :user_id, :in_progress, :created_at, :updated_at, :properties
  attributes :application

  def application
  	entry = {}
  	entry.merge!(application_name: object.dynamic_form_type.name, id: object.id, in_progress: object.in_progress, 
  															created: object.created_at, updated: object.updated_at)

  	object.properties.each_value do |value|
  		if DynamicFormsEngine::DynamicFormField.field_with_null_value.include?(value[:type])
  			next
  		else 
  			entry[value[:name]] = value[:value]	
  		end
  	end
  	entry
  	
  end


end
