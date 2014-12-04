class ApisController < ApplicationController
 	def contact_field
		@contact = Contact.new
		render "apis/contact_field", 
			:content_type => 'text/plain',
			:layout => false
	end

end
