DynamicFormsEngine::DynamicFormEntriesController.class_eval do
  http_basic_authenticate_with name: 'tenant_app', password: 'sfrent', only: :tenant_applications

  require "net/http"
  require "uri"

  skip_before_filter :authenticate_user!, only: [:tenant_applications]
  # before_filter :autocomplete_feature, only: [:new, :edit,:create, :update]
  before_filter :get_buildings, only: [:new, :edit, :create, :update, :show, :index]
  # before_filter :get_contacts, only: [:show]

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
      uri = URI.parse('https://sfrent.net/tenant_app_api.json')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      request.basic_auth('tenant_app','sfrent')
      @building_apartments = http.request(request).body
    end

    def tenant_applications
      if params[:last_app_submitted].present?
        @all_entries = DynamicFormsEngine::DynamicFormEntry.applications_to_be_synced(params[:last_app_submitted])
      else
        @all_entries = DynamicFormsEngine::DynamicFormEntry.last_form_type_entries #all form entries
      end
      respond_to do |format|
        format.json { render json: @all_entries, root: false }
      end
    end
end
