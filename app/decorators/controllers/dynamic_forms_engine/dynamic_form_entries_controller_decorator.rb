DynamicFormsEngine::DynamicFormEntriesController.class_eval do
	before_filter :autocomplete_feature, only: [:new, :edit,:create, :update]
	before_filter :get_contacts, only: [:show]


	def get_contacts
		@contacts = Contact.where(id: Contactable.select(:contact_id).where(:contactable_type => "DynamicFormsEngine::DynamicFormEntry",:contactable_id => params[:id]))
	end

	def autocomplete_feature
		if !current_user.nil?
		    @contacts_hash = {}
		    current_user.contacts.each do |contact|
		      @contacts_hash[contact.first_name] = [contact.contact_type, contact.phone, contact.email, contact.company]
		    end    
		    @contact_names = @contacts_hash.keys
		end
  	end
end