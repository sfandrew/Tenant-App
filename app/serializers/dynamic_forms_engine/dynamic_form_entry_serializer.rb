class DynamicFormsEngine::DynamicFormEntrySerializer < ActiveModel::Serializer
  attributes :id, :dynamic_form_type_id, :user_id, :in_progress, :created_at, :updated_at, :properties
end
