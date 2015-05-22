DynamicFormsEngine::DynamicFormEntriesController.class_eval do

	http_basic_authenticate_with name: 'tenant_app', password: 'sfrent', only: :tenant_applications

	require "net/http"
	require "uri"

	before_filter :autocomplete_feature, only: [:new, :edit,:create, :update]
	before_filter :get_buildings, only: [:new, :edit, :create, :update, :show]
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

  	def get_buildings
  		uri = URI.parse('http://192.168.2.109:3000/tenant_app_api.json')
  		http = Net::HTTP.new(uri.host, uri.port)
  		request = Net::HTTP::Get.new(uri.request_uri)
  		request.basic_auth('tenant_app','sfrent')
  		@building_apartments = http.request(request).body
  	end

  	def tenant_applications
  		@all_entries = DynamicFormsEngine::DynamicFormEntry.all
  		respond_to do |format|
  			format.json { render json: @all_entries }
  		end
  	end
end