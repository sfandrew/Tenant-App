DynamicFormsEngine::DynamicFormTypesController.class_eval do
	before_filter :is_superuser?
end