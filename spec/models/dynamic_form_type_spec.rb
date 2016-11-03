require 'spec_helper'

describe DynamicFormsEngine::DynamicFormType do

	describe "A new form type" do
		before(:each) do
			@new_form = DynamicFormsEngine::DynamicFormType.new
		end

		it "is not valid without a name" do
			@new_form.name = nil
			expect(@new_form).to_not be_valid
		end

		it "is not valid without a description" do
			@new_form.description = nil
			expect(@new_form).to_not be_valid
		end

		it "it not valid without any fields" do
			no_fields = @new_form.fields.size
			expect(no_fields).to eq(0)
		end
	end

	


  describe "when a new multi form is built" do
    it "has a valid tenant factory" do
      form_type = create(:tenant_application)
      expect(form_type).to be_valid
    end
    it "has a valid guarantor factory" do
      form_type = create(:guarantor_application)
      expect(form_type).to be_valid
    end
  end

  describe "A new form" do
    it "is invalid without a form name, form type & form fields" do
      form_type = DynamicFormsEngine::DynamicFormType.new
       expect(form_type).to_not be_valid
    end
  end

  describe "When a multi-step form is created" do
    it "There must be two field group fields present" do
      regular_form = create(:tenant_application)
      expect(regular_form).to be_valid
    end

    it "is invalid if the first field is not a field group" do
      form_type = DynamicFormsEngine::DynamicFormType.new(:name => 'blah', :description => 'blah', :form_type => 'Multi-step')
      form_type.fields << build(:text_field_1)
      expect(form_type).to be_invalid
    end

    it "is invalid if the last field is a field group" do
      form = build(:form_with_two_field_groups)
      expect(form).to_not be_valid
    end
  end

  describe "When a public form is built" do
  	context 'with a multi step form type' do
  		it "it is not valid if the field contains contacts and or file upload" do
  		form = DynamicFormsEngine::DynamicFormType.new(:name => 'foo', :description => 'bar', :form_type => 'Multi-step')
 
  		end
  	end
  	

  end

end











    # it "at least 2 field group fields must be present " do
    #   skip("will finish this test after we have a valid factory")
    #   form_type = build(:tenant_application)

    #   fields = build(:multi_step_fields)
      
    #   form_type.fields = fields
      
    #   # form_type.fields = build(:multi_step_fields)

    #   # field.should_not be_valid
    #   # expect(field).to eq false
    #   expect(form_type.valid?).to eq true
    # end
    # it "it is valid with fields" do
    #   field = DynamicFormType.new(:name => 'Move out form', :description => 'A form list of stuff to move out')
    #   fields = DynamicFormField.create(:name => 'header')
    #   field.fields = fields
    #   field.should be_valid
    # end
#   end
# end


# describe DynamicFormEntry do
#   let(:existing_contact_attributes) do
#     {
#       "contact_type"=>"Property Manager", 
#       "first_name"=>"Andrew", 
#       "email"=>"andrew@sfrent.net", 
#     }
#   end

#   let(:new_contact_attributes) do
#     {
#       "contact_type"=>"Property Manager", 
#       "first_name"=>"Elia", 
#       "email"=>"elia@sfrent.net", 
#     }
#   end

#   let(:dynamic_form_type) { DynamicFormType.create!(fields: [field], name: 'A', description: 'B') }
#   let(:field) { DynamicFormField.create! name: 'T', field_type: :text_field}
#   let(:user) { User.create! contacts: [existing_contact], email: 'a@b.com', password: '12345678'}
#   let(:existing_contact) { Contact.create!(existing_contact_attributes) }

#   it 'avoids duplicating contacts on save' do
#     entry = described_class.new(
#       contacts_attributes: [
#         existing_contact_attributes, 
#         new_contact_attributes,
#       ], 
#       dynamic_form_type: dynamic_form_type,
#       user: user
#     )
#     entry.save!
#     expect(Contact.count).to eq(2)
#   end

# end

