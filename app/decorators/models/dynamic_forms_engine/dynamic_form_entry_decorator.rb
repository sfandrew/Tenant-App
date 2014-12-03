DynamicFormsEngine::DynamicFormEntry.class_eval do
  has_many  :contacts, through: :contactables, :dependent => :destroy
  has_many  :contactables, :as => :contactable, :dependent => :destroy
  accepts_nested_attributes_for :contacts,  :allow_destroy => :true

  before_validation :new_contacts_validation
  after_validation :create_attachment, :if => Proc.new { |properties| !properties.properties.nil? }
  # after_validation :email_user
  # before_save :email_contacts
  # before_validation :new_contacts
  #before_update :new_contacts
   

  def new_contacts_validation
    if !self.contacts.empty?
      current_user_contacts = self.user.contacts.pluck(:email)
      self.contacts.each do |contact|
        # deletes empty contacts
        if contact.first_name.empty? && contact.contact_type.blank? && contact.email.blank? && contact.company.blank?
          self.contacts.delete(contact)
        #saves only new contacts       
        elsif current_user_contacts.include?(contact.email)
          matching_contact = self.user.contacts.where(email: contact.email).first
          self.contacts.delete(contact)
          self.contacts << matching_contact if !self.contacts.pluck(:id).include?(matching_contact.id)
        else
          contact.set_user_id(self.user_id)
          self.contacts << contact if !self.new_record?
        end
      end
    end
  end

  def create_attachment
        self.properties.each_pair do |property_id, property_value|
          field = DynamicFormsEngine::DynamicFormField.find(property_id)
          if field.attachment?
            attachment_id = self.id || DynamicFormsEngine::DynamicFormEntry.last.id+1

            file_attachment = Attachment.create!(attachable_id: attachment_id,
                                                user_id: self.user.id,
                                                attachable_type: 'DynamicFormEntry',
                                                content_name: field.name, 
                                                filename: property_value[0])
              
            self[:properties][property_id] = file_attachment.id
          end
        end
    end

  def email_user
  	if !self.contacts.empty?
  		FormEntry.form_entry_notification(self, :contact => self.contacts).deliver
  	else
  		FormEntry.form_entry_notification(self).deliver
  	end

  end
  def email_contacts
  	if !self.contacts.empty?
  		self.contacts.each do |contact|
  			FormEntry.form_entry_contacts(self,contact).deliver
  		end
  		new_contacts
  	end
  end



end