DynamicFormsEngine::DynamicFormFieldsController.class_eval  do

	http_basic_authenticate_with name: 'tenant_app', password: 'sfrent', only: :field_with_values

	def field_with_values
		@values = DynamicFormsEngine::DynamicFormField.all_fields_with_values
		respond_to do |format|
			format.json { render json: @values, root: false }
		end
	end
	
end