class Transaction < ActiveRecord::Base
	belongs_to :dynamic_form_entry, class_name: "DynamicFormsEngine::DynamicFormEntry"
end
