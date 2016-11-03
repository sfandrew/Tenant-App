####

FactoryGirl.define do
  factory :tenant_application, class: DynamicFormsEngine::DynamicFormType do
    name "Tenant-Application"
    description "Filling out tenants apps"
    form_type "Multi-step"

    after(:build) do |instance|
      instance.fields << FactoryGirl.build(:field_group_1)
      instance.fields << FactoryGirl.build(:text_field_1)
      instance.fields << FactoryGirl.build(:field_group_2)
      instance.fields << FactoryGirl.build(:text_field_2)
    end
  end

  
  
  factory :guarantor_application, class: DynamicFormsEngine::DynamicFormType do
    name "Guarantor Application"
    description "Filling out guarantor apps"
    form_type  "Multi-step"

    after(:build) do |instance|
      instance.fields << FactoryGirl.build(:field_group_1)
      instance.fields << FactoryGirl.build(:text_field_1)
      instance.fields << FactoryGirl.build(:field_group_2)
      instance.fields << FactoryGirl.build(:text_field_2)
    end
  end

  factory :form_with_one_field_group, class: DynamicFormsEngine::DynamicFormType do
    name "Some form"
    description "More info"
    form_type "Multi-step"

    after(:build) do |instance|
      instance.fields << FactoryGirl.build(:field_group_1)
    end
  end

  factory :form_with_two_field_groups, class: DynamicFormsEngine::DynamicFormType do
    name "Tenant Application"
    description "More info"
    form_type "Multi-step"

    after(:build) do |instance|
      instance.fields << FactoryGirl.build(:field_group_1)
      instance.fields << FactoryGirl.build(:text_field_1)
      instance.fields << FactoryGirl.build(:field_group_2)
    end
  end

end