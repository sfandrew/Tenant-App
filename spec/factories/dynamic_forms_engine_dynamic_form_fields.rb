##

FactoryGirl.define do
  factory :fields, class: DynamicFormsEngine::DynamicFormField do

    required 0
    field_width "12"
    sequence(:name) { |n| "This is field #{n}" }
    sequence(:field_order) { |n| "#{n}".to_i - 1}
    
    factory :field_group_1 do
      field_type "field_group"
    end

    factory :text_field_1 do
      field_type "text_field"
    end

    factory :contacts_field_1 do
      field_type "contacts"
    end

    factory :field_group_2 do
      field_type "field_group"
    end

    factory :text_field_2 do
      field_type "text_field"
    end
    
  end
end