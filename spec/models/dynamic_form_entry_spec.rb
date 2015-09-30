require 'spec_helper'

describe DynamicFormType do
  describe "when a new form is created" do
    it "is not valid without fields" do
      field = DynamicFormType.new(:name => 'Move out form', :description => 'A form list of stuff to move out')
      # field.should_not be_valid
      # expect(field).to eq false
      expect(field.valid?).to eq false
      field.should_not be_valid
    end
    # it "it is valid with fields" do
    #   field = DynamicFormType.new(:name => 'Move out form', :description => 'A form list of stuff to move out')
    #   fields = DynamicFormField.create(:name => 'header')
    #   field.fields = fields
    #   field.should be_valid
    # end
  end
end


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

