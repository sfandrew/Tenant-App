DynamicFormsEngine::DynamicFormTypesController.class_eval do

	before_filter :is_admin?, :except => [:index]
end