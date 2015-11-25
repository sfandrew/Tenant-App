DynamicFormsEngine::DynamicFormEntry.class_eval do
  has_many  :contacts, through: :contactables, :dependent => :destroy
  has_many  :contactables, :as => :contactable, :dependent => :destroy
  has_many :attachments, :as => :attachable, :dependent => :destroy

  scope :last_form_type_entries, -> { where(in_progress: false) } #all entries
  scope :applications_to_be_synced, -> (last_app_synced) { where('in_progress = ? AND created_at >= ?', false, last_app_synced) } # applications that have been completed 

  accepts_nested_attributes_for :contacts,  :allow_destroy => :true
  accepts_nested_attributes_for :attachments, :allow_destroy => :true, reject_if: proc { |attributes| attributes["filename"].blank? }

  encrypt_with_public_key :social_security,
    :key_pair => ENV['KEY_PAIR'], 
    :base64 => true

  before_validation :new_contacts_validation

  # after_validation :create_attachment, :if => Proc.new { |properties| !properties.properties.nil? }
  # after_validation :email_user
  # before_save :email_contacts
  # before_validation :new_contacts
  #before_update :new_contacts

  def self.redirect_to_user_draft_entry(user)
    if user.dynamic_form_entries
      in_progress_entry = user.dynamic_form_entries.order(updated_at: :desc).detect { |entry| entry.in_progress } || nil
      if !in_progress_entry.nil?
        in_progress_entry.id
      else
        false
      end
    else
      false 
    end
  end

  def get_building_name(buildings)
    json_buildings = JSON.parse(buildings)
    properties.each_pair do |index, value|
      if value[:name] == 'Building'
        building = json_buildings["buildings"].find { |building| value[:value].to_i == building["id"].to_i }
        return building["name"] unless building.nil?
      end
    end
    'None at the moment'
  end

  def get_building_size
    properties.each_pair do |index,value|
      if value[:name] == 'Apartment Size'
        return value[:value]
      end
    end
    'None at the moment'
  end


  def find_attachment(field_id)
    if attachments.present?
      attachments.find{|x| x.content_meta == field_id.to_s }
    end
  end
   
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
         # raise
          # field = DynamicFormsEngine::DynamicFormField.find(property_id)
          # if field.attachment?
          #   attachment_id = self.id || DynamicFormsEngine::DynamicFormEntry.last.id+1

          #   file_attachment = Attachment.create!(attachable_id: attachment_id,
          #                                       user_id: self.user.id,
          #                                       attachable_type: 'DynamicFormEntry',
          #                                       content_name: field.name, 
          #                                       filename: property_value[0])
              
          #   self[:properties][property_id] = file_attachment.id
          # end
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

  def building_name(building_id,buildings_object)
    json_buildings = JSON.parse(buildings_object)
    building = json_buildings["buildings"].find { |building|  building_id.to_i == building["id"] } 
    building["name"] 
  end



end